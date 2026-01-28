extends Node2D

#var camera_list: Array[Camera] = []

func _ready() -> void:
	for camera in get_children():
		if camera is Camera:
			Game.camera_list.append(camera)

