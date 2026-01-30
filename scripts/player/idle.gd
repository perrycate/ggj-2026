extends PlayerState

func physics_update(delta: float) -> void:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		transition.emit(self, "Moving")
		return

	body.velocity = body.velocity.move_toward(Vector2.ZERO, deceleration * delta)
	body.move_and_slide()
