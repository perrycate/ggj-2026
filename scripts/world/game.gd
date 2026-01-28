extends Node2D


var player: PackedScene = preload("res://scenes/world/player.tscn")
var watcher: PackedScene = preload("res://scenes/watcher/watcher.tscn")
var camera_list: Array[Camera] = []
var is_player: bool = false

@onready var cameras_node: Node2D = $Cameras

# TODO add mechanism for getting/sharing this.
const server_address = "127.0.0.1"
const PORT = 5000
const MAX_PEERS = 1

@export var game_node_path: NodePath
@export var is_watcher = false

func _ready():
	pass

func _on_join_button_pressed():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(server_address, PORT)
	if error:
		return error

	multiplayer.multiplayer_peer = peer

	print("joined")
	get_tree().current_scene.add_child(player.instantiate())
	get_tree().current_scene.add_child(watcher.instantiate())


func _on_host_button_pressed():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_PEERS)
	if error:
		return error

	multiplayer.multiplayer_peer = peer

	print("hosting")

	var p = player.instantiate()
	is_player = true
	p.is_active = true
	
	get_tree().current_scene.add_child(p)

#func get_camera_list():
	
