extends Node2D

var player: PackedScene = preload("res://scenes/world/player.tscn")

const DEFAULT_PORT = 4267

const MAX_PEERS = 1

# We cache the previous state to avoid sending more game updates
# than necessary over the network.
var prev_state = {}

func _ready() -> void:
	OS.set_environment("GODOT_VERBOSE", "1")

func _physics_process(_delta: float) -> void:
	if !$Network.is_host:
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

	WARNING: Make sure the data structure here stays in sync with the one
	used in set_positions!
	(PC: I sure wish gdscript let us define our own types. :/)
	"""

	return {"player_position": $Player.position}


@rpc
func set_positions(new_state) -> void:
	"""
	Accepts a dict containing game state, and updates the
	corresponding positions.

	This should be called on the client with data obtained on the host.

	WARNING: Make sure the data structure here stays in sync with the one
	returned by get_positions!
	(PC: I sure wish gdscript let us define our own types. :/)
	"""
	print(new_state)
	$Player.position = new_state["player_position"]

func _on_join_button_pressed():
	$Network.search_for_host()

func _on_host_button_pressed():
	# Create server.
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(DEFAULT_PORT, MAX_PEERS)
	if error:
		return error

	multiplayer.multiplayer_peer = peer

	print("hosting")

	# Broadcast in search of peers.
	$Network.search_for_clients()

	var p = player.instantiate()
	p.is_active = true
	$Network.is_host = true
	
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
