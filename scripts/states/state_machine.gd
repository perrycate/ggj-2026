extends Node
class_name StateMachine

@export var initial_state: State

var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	if !is_multiplayer_authority():
		set_process(false)
		set_physics_process(false)
		set_process_input(false)
		#return
	
	for child in get_children():
		if child is State:
			print(child)
			states[child.name] = child
			child.transition.connect(on_child_transition)
	
	if initial_state:
		initial_state.enter("")
		current_state = initial_state

func _process(delta: float):
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
		
func on_child_transition(state, new_state_name, _message = ""):
	if state != current_state:
		print("state != current state")
		return
		
	var new_state = states.get(new_state_name)
	if !new_state:
		print("!new state")
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter(_message)
	
	current_state = new_state

func transition_to(new_state_name, _message):
	var new_state = states.get(new_state_name)
	if !new_state:
		return
	if current_state:
		current_state.exit()
	new_state.enter(_message)
	current_state = new_state
