extends WatcherState
class_name WatcherSwitching

var _switch_timer: float = 0.0

const SWITCH_TIME: float = 1.0  # seconds

@onready var game_node = $"/root/Game"
@onready var cameras_node = $"/root/Game/Cameras"

func enter(_message):
	super(_message)

	# CT: todo - need to have some sort of "fuzzy" screen appear
	_switch_timer = SWITCH_TIME

	watcher.current_camera_idx = (watcher.current_camera_idx + 1) % watcher.camera_list.size()

func update(_delta: float):
	super(_delta)
	_switch_timer -= _delta
	#print("switch timer: ", _switch_timer)
	if _switch_timer <= 0.0:
		#print("transitioning")
		# CT: todo - need to make the fuzzy screen disappear
		transition.emit(self, "Controlling", NO_MESSAGE)
