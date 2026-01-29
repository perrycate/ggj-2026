extends CharacterBody2D
class_name Camera

var is_active: bool = false
const CAMERA_SPEED: float = 200

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if is_active:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_direction * CAMERA_SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()



