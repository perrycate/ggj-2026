extends Node2D

@onready var game_node = get_parent()
#var camera_list: Array[Camera] = []

func _ready() -> void:
	for camera in get_children():
		if camera is Camera:
			print("adding camera: ", camera)
			game_node.add_camera(camera)

	print("camera list:")
	for camera in game_node.camera_list:
		print("found camera: ", camera)

@rpc("any_peer")
func configure_authority(peer_id: int) -> void:
	print("configuring authority")
	for camera in get_children():
		camera.configure_authority(peer_id)
