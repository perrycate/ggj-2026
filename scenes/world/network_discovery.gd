extends Node

const DEFAULT_LISTEN_PORT = 4269
const MULTICAST_ADDR = "239.0.0.0"

@export var is_host = false

enum State {
	# Player hasn't selected if they want to host or join.
	INACTIVE,

	# Player wants to host, and we are broadcasting to potential peers.
	BROADCASTING,

	# Player wants to join, and we are listening for a host.
	LISTENING,

	# Peer is found, nothing to do.
	CONNECTED,
}

var current_state = State.INACTIVE
var socket: PacketPeerUDP

func _process(_delta: float) -> void:
	var err

	match current_state:
		State.INACTIVE || State.CONNECTED:
			return
		State.BROADCASTING:
			err = socket.put_packet("hi".to_utf8_buffer())
			quit_on_error(err)
		State.LISTENING:
			if !socket.get_available_packet_count():
				return

			print("packet!")
			print(socket.get_packet_ip())
			print(socket.get_packet_port())
			print(socket.get_packet())

			var parent = get_parent()

			err = parent.establish_connection(socket.get_packet_ip())
			quit_on_error(err)

			current_state = State.CONNECTED


func search_for_clients():
	var err
	socket = PacketPeerUDP.new()

	err = socket.bind(0)
	quit_on_error(err)

	# Broadcast to anyone listening.
	err = socket.set_dest_address(
		MULTICAST_ADDR,
		DEFAULT_LISTEN_PORT,
	)
	quit_on_error(err)

	current_state = State.BROADCASTING


func search_for_host():
	var err
	socket = PacketPeerUDP.new()

	err = socket.bind(DEFAULT_LISTEN_PORT)
	quit_on_error(err)

	# Listen on all interfaces.
	for iface in IP.get_local_interfaces():
		print(iface)
		err = socket.join_multicast_group(MULTICAST_ADDR, iface["name"])
		quit_on_error(err)

	current_state = State.LISTENING


func quit_on_error(error: int) -> void:
	assert(!error)
