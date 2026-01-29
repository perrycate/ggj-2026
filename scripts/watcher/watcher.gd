extends Node2D

class_name Watcher

var current_camera: Node2D = null
var current_camera_index: int = 0

@onready var cameras = get_parent().get_node("Cameras")
@onready var game_node = $"/root/Game"

func _ready() -> void:
	pass

func _process(_delta: float):
	pass

func increment_camera_index(increment_value: int):
	current_camera_index += increment_value
	if current_camera_index > game_node.camera_list.size()-1:
		current_camera_index = 0
	elif current_camera_index < 0:
		current_camera_index = game_node.camera_list.size()-1

	current_camera = game_node.camera_list[current_camera_index]


func _on_infrared_button_pressed() -> void:
	pass # Replace with function body.
