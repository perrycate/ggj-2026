extends State
class_name WatcherControlling

func _read() -> void:
	pass

func enter(_message):
	super(_message)
	# CT: allow the camera to move
	base_node.current_camera.is_active = true  

func exit():
	super()
	# CT: stop the camera from moving
	base_node.current_camera.is_active = false

func update(_delta: float):
	# CT: needs to check for input to switch cameras
	# CT: mask switching logic (probably) will be controlled in the camera
	if Input.is_action_pressed("next_camera"):
		transition.emit(self, "Switching", 1)
	elif Input.is_action_pressed("previous_camera"):
		transition.emit(self, "Switching", -1)
	pass

func physics_update(_delta: float):
	base_node.global_position = base_node.current_camera.global_position
	pass
