extends Node
class_name State

signal transition

var active: bool = false

const NO_MESSAGE: String = ""

@onready var base_node: Node2D = $"../.."

func _ready() -> void:
	pass

func enter(_message):
	active = true
	
func exit():
	active = false
	
func update(_delta: float):
	"""
	Called by the state machine during _update_physics when this is the current state.
	"""
	pass
	
func physics_update(_delta: float):
	pass

func transition_to_state(new_state_name: String, message):
	transition.emit(self, new_state_name, message)
