extends Node2D


var player: PackedScene = preload("res://scenes/player/player.tscn")
var watcher: PackedScene = preload("res://scenes/watcher/watcher.tscn")
var camera_list: Array[Camera] = []

@onready var cameras_node = $Cameras
@onready var network: Node = $Network

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

func _on_join_button_pressed():
	if IS_LOCAL_ONLY:
		establish_connection("127.0.0.1")
		return
	network.search_for_host()

func _on_host_button_pressed():
	# Create server.
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(DEFAULT_PORT, MAX_PEERS)
	if error:
		return error

	multiplayer.multiplayer_peer = peer

	print("hosting")

	if !IS_LOCAL_ONLY:
		# Broadcast in search of peers.
		network.search_for_clients()

	var p = player.instantiate()
	
	get_tree().current_scene.add_child(p)

func establish_connection(server_address: String) -> int:
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(server_address, DEFAULT_PORT)
	if error:
		return error

	multiplayer.multiplayer_peer = peer
	get_tree().current_scene.add_child(player.instantiate())
	print("joined")

	return 0

func add_camera(camera: Camera):
	if camera != null:
		camera_list.append(camera)
	

