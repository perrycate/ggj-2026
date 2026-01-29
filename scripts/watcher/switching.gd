extends WatcherState
class_name WatcherSwitching

var _switch_timer: float = 0.0

const SWITCH_TIME: float = 1.0  # seconds

@onready var game_node = $"/root/Game"
@onready var cameras_node = $"/root/Game/Cameras"

func enter(_message):
	super(_message)

	# CT: this prevents a race condition
	if !cameras_node.is_node_ready():
		print("awaiting  cameras_node...")
		await cameras_node.ready

	# CT: todo - need to have some sort of "fuzzy" screen appear
	_switch_timer = SWITCH_TIME
	switch_cameras(_message)

func update(_delta: float):
	super(_delta)
	_switch_timer -= _delta
	#print("switch timer: ", _switch_timer)
	if _switch_timer <= 0.0:
		#print("transitioning")
		# CT: todo - need to make the fuzzy screen disappear
		transition.emit(self, "Controlling", NO_MESSAGE)

func switch_cameras(increment_value) -> void:
	if increment_value is String or increment_value == null or increment_value == 0:
		print("Switching: getting first camera")
		base_node.current_camera = game_node.camera_list.front()
		base_node.current_camera_index = 0
	else:
		print("Switching: getting next camera: ", increment_value)
		base_node.increment_camera_index(increment_value)
