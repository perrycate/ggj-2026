extends Node2D


var player: PackedScene = preload("res://scenes/player/player.tscn")
var watcher: PackedScene = preload("res://scenes/watcher/watcher.tscn")
var camera_list: Array[Camera] = []

@onready var cameras_node = $Cameras
@onready var network: Node = $Network
@onready var player_spawner = $PlayerSpawner

# To work around wonky network discovery issues, for now.
# TODO: Remove this before playtesting on multiple computers.
const IS_LOCAL_ONLY = true

const DEFAULT_PORT = 4267

const MAX_PEERS = 1

@export var game_node_path: NodePath
@export var is_watcher = false
# We cache the previous state to avoid sending more game updates
# than necessary over the network.
var prev_state = {}

func _ready() -> void:
	OS.set_environment("GODOT_VERBOSE", "1")
	multiplayer.peer_connected.connect(on_peer_connected)

func _on_join_button_pressed():
	if IS_LOCAL_ONLY:
		establish_connection_to_server("127.0.0.1")
		return
	network.search_for_host()


func _on_host_button_pressed():
	# Create server.
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(DEFAULT_PORT, MAX_PEERS)
	if error:
		return error

	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(spawn_player)

	print("hosting")

	if !IS_LOCAL_ONLY:
		# Broadcast in search of peers.
		network.search_for_clients()


func establish_connection_to_server(server_address: String):
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(server_address, DEFAULT_PORT)
	if error:
		return error

	multiplayer.multiplayer_peer = peer

func add_camera(camera: Camera):
	if camera != null:
		camera_list.append(camera)

func spawn_player(_peer_id):
	print("spawning")
	var p = player.instantiate()
	p.authority_peer_id = 1 # Server. TODO don't hardcode shit.
	player_spawner.add_child(p, true)


func on_peer_connected(peer_id: int):
	print("connected to peer: ", peer_id)
