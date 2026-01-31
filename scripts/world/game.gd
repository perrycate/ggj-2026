extends Node2D


var player: PackedScene = preload("res://scenes/player/player.tscn")
var camera: PackedScene  =preload("res://scenes/camera/camera.tscn")
var watcher: PackedScene = preload("res://scenes/watcher/watcher.tscn")

@onready var network: Node = $Network
@onready var player_spawner = $PlayerSpawner
@onready var camera_spawner = $CameraSpawner

# To work around wonky network discovery issues, for now.
# TODO: Remove this before playtesting on multiple computers.
const IS_LOCAL_ONLY = true

const DEFAULT_PORT = 4267

const MAX_PEERS = 1

@export var game_node_path: NodePath
@export var is_watcher = false

var cameras: Array[Camera] = []

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
	multiplayer.peer_connected.connect(spawn_player)

func _on_host_button_pressed():
	# Create server.
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(DEFAULT_PORT, MAX_PEERS)
	if error:
		return error

	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(start_game)

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

	print("connecting to server")

func start_game(_player_peer_id):
	for spawn_location in $CameraSpawner.get_children():
		var c = camera.instantiate()
		c.position = spawn_location.position
		cameras.append(c)
		camera_spawner.add_child(c, true)

	spawn_watcher()
	spawn_player.rpc()

func spawn_watcher():
	var w = watcher.instantiate()
	w.camera_list = cameras
	camera_spawner.add_child(w, true)
	
@rpc
func spawn_player():
	var p = player.instantiate()
	p.name = str(multiplayer.multiplayer_peer.get_unique_id())
	p.position = $PlayerSpawnPoint.position
	player_spawner.add_child(p, true)

func on_peer_connected(peer_id: int):
	print("connected to peer: ", peer_id)
