extends Node2D

var player: PackedScene = preload("res://scenes/world/player.tscn")

# TODO add mechanism for getting/sharing this.
const server_address = "127.0.0.1"
const PORT = 5000
const MAX_PEERS = 1


@export var is_host = false

# We cache the previous state to avoid sending more game updates
# than necessary over the network.
var prev_state = {}

func _physics_process(_delta: float) -> void:
	if !is_host:
		return

	call_deferred("broadcast_game_state")


func broadcast_game_state() -> void:
	"""
	Sends out an rpc with the position/state of the player.

	This should be called by the host, after all movement logic is executed.

	Once we have other entities (enemies etc) moving around, we
	should probably send that info out here as well.
	"""
	var state = get_positions()

	if state == prev_state:
		return

	set_positions.rpc(state)
	prev_state = state


func get_positions():
	"""
	Returns a dictionary containing any game state that needs to be
	kept in sync between the host and the client(s).
	"""

	return {"player_position": $Player.position}


@rpc
func set_positions(new_state) -> void:
	"""
	Accepts a dict containing game state, and updates the
	corresponding positions.

	This should be called on the client with data obtained on the host.
	"""
	print(new_state)
	$Player.position = new_state["player_position"]


func _on_join_button_pressed():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(server_address, PORT)
	if error:
		return error

	multiplayer.multiplayer_peer = peer

	print("joined")
	get_tree().current_scene.add_child(player.instantiate())

func _on_host_button_pressed():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_PEERS)
	if error:
		return error

	multiplayer.multiplayer_peer = peer

	print("hosting")

	var p = player.instantiate()
	p.is_active = true
	is_host = true
	
	get_tree().current_scene.add_child(p)
