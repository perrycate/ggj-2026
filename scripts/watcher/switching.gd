extends WatcherState
class_name WatcherSwitching

var _switch_timer: float = 0.0

const SWITCH_TIME: float = 1.0  # seconds

func enter(_message):
	super(_message)
	_switch_timer = SWITCH_TIME
	switch_cameras(_message)

func update(_delta: float):
	super(_delta)
	_switch_timer -= _delta
	if _switch_timer <= 0:
		transition.emit(self, "WatcherControlling", NO_MESSAGE)

func switch_cameras(new_camera_index) -> void:
	if new_camera_index == null or new_camera_index == 0:
		base_node.current_camera = Game.cameras.front()
		base_node.current_camera_index = 1
	else:
		base_node.current_camera = Game.cameras[new_camera_index]

