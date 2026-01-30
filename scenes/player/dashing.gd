extends PlayerState

func _ready() -> void:
	$AccelTimer.timeout.connect(on_accel_timeout)

func on_accel_timeout():
	print("slowing")
	$DecelTimer.start()

func enter(message):
	super(message)
	print("accelerating")
	$AccelTimer.start()

func physics_update(delta: float) -> void:
	if $AccelTimer.time_left == 0 and $DecelTimer.time_left == 0:
		# The dash is over.
		transition.emit(self, "Moving")

	if $AccelTimer.time_left > 0:
		# Accelerate up to a higher dash speed.
		body.velocity += body.velocity * acceleration * delta
		body.velocity = body.velocity.limit_length(max_dash_speed)

	if $DecelTimer.time_left > 0:
		# Decelerate towards the normal walking speed.
		body.velocity = body.velocity.lerp(
			body.velocity.normalized()*max_speed,
			$DecelTimer.wait_time - $DecelTimer.time_left,
		)

	body.move_and_slide()
