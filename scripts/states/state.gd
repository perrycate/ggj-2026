extends Node
class_name State

signal transition

const NO_MESSAGE: String = ""

@onready var base_node: Node2D = $"../.."

func _ready() -> void:
	pass

func enter(_message):
	print(base_node.name, " entering state: ", name)
	pass
	
func exit():
	pass
	
func update(_delta: float):
	"""
	Called by the state machine during _update_physics when this is the current state.
	"""
	pass
	
func physics_update(_delta: float):
	pass

func transition_to_state(new_state_name: String, message):
	transition.emit(self, new_state_name, message)
