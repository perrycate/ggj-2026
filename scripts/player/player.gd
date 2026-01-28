extends CharacterBody2D


# Whether the human playing is actively controlling or merely watching.
# PC: This feels wrong? Need to think about state management asap.

@onready var state_machine: Node = $StateMachine

var is_active: bool = false

@export var acceleration := 10000.0
@export var deceleration := 5000.0
@export var max_speed := 500.0

func _ready():
	# TODO: if you don't have authority:
	#set_process(false)
	#set_physics_process(false)
	#set_process_input(false)
	#state_machine.set_process(false)
	#state_machine.set_physics_process(false)
	pass

func _physics_process(delta: float) -> void:
	if !is_active:
		return

	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity += input_direction * acceleration * delta
	velocity = velocity.limit_length(max_speed)

	if input_direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	move_and_slide()
