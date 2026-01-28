extends Node

class_name State

signal transition

const NO_MESSAGE: String = ""

@onready var base_node: Node2D = $"../.."
#@onready var body: CharacterBody3D = $"../.."
#@onready var animation_player: AnimationPlayer = $"../../Mesh/AnimationPlayer"
#@onready var animation_tree: AnimationTree = $"../../Mesh/AnimationTree"

var state_name: String = "none"

func _ready() -> void:
	state_name = get_script().get_global_name()
	print(base_node.name, " state name: ", state_name)
	#print(body.character_name, " state name: ", state_name)

func enter(_message):
	print(base_node.name, " entering state: ", state_name)
	#print(body.character_name, " entering state: ", state_name)
	pass
	
func exit():
	print(base_node.character_name, " exiting state: ", state_name)
	#body.move_and_slide()
	pass
	
func update(_delta: float):
	pass
	
func physics_update(_delta: float):
	#body.move_and_slide()
	pass

func transition_to_state(new_state_name: String, message):
	transition.emit(self, new_state_name, message)
