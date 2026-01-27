extends CharacterBody2D
class_name Camera

const CAMERA_SPEED: float = 200

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * CAMERA_SPEED

	move_and_slide()



