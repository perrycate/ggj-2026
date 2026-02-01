extends WatcherState
class_name WatcherControlling

func _read() -> void:
	pass

func enter(_message):
	super(_message)
	# CT: allow the camera to move
	watcher.get_current_camera().activate()

func exit():
	super()
	# CT: stop the camera from moving
	watcher.get_current_camera().deactivate()

func update(_delta: float):
	# CT: needs to check for input to switch cameras
	# CT: mask switching logic (probably) will be controlled in the camera
	if Input.is_action_pressed("next_camera"):
		transition.emit(self, "Switching", 1)
	elif Input.is_action_pressed("previous_camera"):
		transition.emit(self, "Switching", -1)
	pass

func physics_update(_delta: float):
	watcher.global_position = watcher.get_current_camera().global_position
	pass

func attempt_mask_change(mask: String):
	if active:
		watcher.get_current_camera().change_mask(mask)

func _on_visual_button_pressed() -> void:
	attempt_mask_change("Visual")

func _on_infrared_button_pressed() -> void:
	attempt_mask_change("Infrared")

func _on_night_vision_button_pressed() -> void:
	attempt_mask_change("NightVision")

func _on_acoutstic_button_pressed() -> void:
	attempt_mask_change("Acoustic")
