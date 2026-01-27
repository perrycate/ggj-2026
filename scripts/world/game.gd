extends Node2D

# TODO add mechanism for getting/sharing this.
const server_address = "127.0.0.1"
const PORT = 5000

func _ready():
	multiplayer.peer_connected.connect(_on_watcher_connected)

func _on_watcher_connected():
	pass

func _on_join_button_pressed():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(server_address, PORT)
	if error:
		return error

	multiplayer.multiplayer_peer = peer

