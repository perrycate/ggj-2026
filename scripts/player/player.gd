extends CharacterBody2D

var speed : float = 300

func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

	move_and_slide()

	if velocity != Vector2.ZERO:
		_on_player_moved.rpc(position)

@rpc
func _on_player_moved(new_position: Vector2):
	position = new_position
