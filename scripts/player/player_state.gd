extends State
class_name PlayerState

const acceleration := 10000.0
const deceleration := 5000.0
const max_speed := 500.0

@onready var body: CharacterBody2D = $"../.."
