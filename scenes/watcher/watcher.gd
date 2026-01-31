extends Node2D

var camera_list: Array[Camera] = []
var current_camera_idx: int = 0

func _enter_tree():
	pass

func get_current_camera() -> Camera:
	return camera_list[current_camera_idx]
