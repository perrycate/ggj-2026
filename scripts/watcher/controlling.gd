extends State
class_name WatcherControlling

func _read() -> void:
	pass

func enter(_message):
	pass

func exit():
	pass

func update(_delta: float):
	# needs to check for input to switch cameras
	# mask switching logic (probably) will be controlled in the camera
	if Input.is_action_pressed("next_camera"):
		transition.emit(self, "WatcherSwitching", "next")
	elif Input.is_action_pressed("previous_camera"):
		transition.emit(self, "WatcherSwitching", "previous")
	pass

func physics_update(_delta: float):
	base_node.global_position = base_node.current_camera.global_position
	pass


