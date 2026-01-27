extends Node2D

# TODO add mechanism for getting/sharing this.
const server_address = "127.0.0.1"
const PORT = 5000
const MAX_PEERS = 1

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

func _on_host_button_pressed():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_PEERS)
	if error:
		return error

	multiplayer.multiplayer_peer = peer

	print("hosting")
