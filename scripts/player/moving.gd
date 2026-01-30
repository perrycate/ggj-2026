extends PlayerState

func physics_update(delta: float) -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction == Vector2.ZERO:
		transition.emit(self, "Idle")
		return

	body.velocity += input_direction * acceleration * delta
	body.velocity = body.velocity.limit_length(max_speed)

	if Input.is_action_pressed("dash"):
		transition.emit(self, "Dashing")

	body.move_and_slide()
