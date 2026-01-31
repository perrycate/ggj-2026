extends Node2D

class_name Watcher

var current_camera: Node2D = null
var current_camera_index: int = 0

@onready var cameras = get_parent().get_node("Cameras")
@onready var game_node = $"/root/Game"
@onready var camera_node: Camera2D = $Camera2D

func _ready() -> void:
	if is_multiplayer_authority():
		print("just the watcher")
		# CT: uncomment this when the watcher is actually spawning in on connection and not by default on game initiation
		#camera_node.enabled = true
		
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
