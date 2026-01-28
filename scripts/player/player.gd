extends CharacterBody2D

# Whether the human playing is actively controlling or merely watching.
# PC: This feels wrong? Need to think about state management asap.

@onready var state_machine: Node = $StateMachine

var is_active: bool = false

var PLAYER_SPEED : float = 300

func _ready():
	# TODO: if you don't have authority:
	#set_process(false)
	#set_physics_process(false)
	#set_process_input(false)
	#state_machine.set_process(false)
	#state_machine.set_physics_process(false)
	pass

func _physics_process(_delta: float) -> void:
	if !is_active:
		return

	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * PLAYER_SPEED

	move_and_slide()

	if velocity != Vector2.ZERO:
		_on_player_moved.rpc(position)

@rpc
func _on_player_moved(new_position: Vector2):
	position = new_position
