extends Node2D

class_name Watcher

var current_camera: Node2D = null
var current_camera_index: int = 1

func _ready() -> void:
	pass

func _process(_delta: float):
	pass

func increment_camera_index(increment_value: int):
	current_camera_index += increment_value
	if current_camera_index > Game.camera_list.size():
		current_camera_index = 1
	elif current_camera_index < 1:
		current_camera_index = Game.camera_list.size()

