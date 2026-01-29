extends State
class_name PlayerState

const acceleration := 10000.0
const deceleration := 5000.0

# Max speed through normal movement.
const max_speed := 500.0

# Max speed during a dash.
const max_dash_speed := 1500.0

@onready var body: CharacterBody2D = $"../.."
