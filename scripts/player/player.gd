extends CharacterBody2D

# Whether the human playing is actively controlling or merely watching.
# PC: This feels wrong? Need to think about state management asap.
var is_active: bool = false

var speed : float = 300

func _ready():
	pass

func _physics_process(_delta: float) -> void:
	if !is_active:
		return

	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

	move_and_slide()
