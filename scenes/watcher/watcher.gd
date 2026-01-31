extends Node2D

var camera_list: Array[Camera] = []
var current_camera_idx: int = 0

@onready var camera_node: Camera2D = $Camera2D

func _enter_tree():
	pass

func _ready() -> void:
	if is_multiplayer_authority():
		camera_node.enabled = true

func get_current_camera() -> Camera:
	return camera_list[current_camera_idx]
