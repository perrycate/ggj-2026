extends Node2D

var minimap_camera: PackedScene = preload("res://scenes/watcher/minimap_camera.tscn")

var camera_list: Array[Camera] = []
var current_camera_idx: int = 0

@onready var camera_node: Camera2D = $Camera2D
@onready var minimap = $SubViewportContainer/SubViewport


func _enter_tree():
	pass

func _ready() -> void:
	if is_multiplayer_authority():
		camera_node.enabled = true

	# Set up minimap.
	for camera in camera_list:
		var mc = minimap_camera.instantiate()
		minimap.add_child(mc)
		camera.minimap_icon = mc

	get_current_camera().activate()

func get_current_camera() -> Camera:
	return camera_list[current_camera_idx]
