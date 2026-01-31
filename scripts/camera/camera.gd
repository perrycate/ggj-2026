extends CharacterBody2D
class_name Camera

var change_cooldown: float = 0
var is_active: bool = false
var player_detected: bool = false

@onready var state_machine = $StateMachine

@onready var visual_spotlight: Sprite2D = $Spotlights/VisualSpotlight
@onready var infrared_spotlight: Sprite2D = $Spotlights/InfraredSpotlight
@onready var night_vision_spotlight: Sprite2D = $Spotlights/NightVisionSpotlight
@onready var acoustic_spotlight: Sprite2D = $Spotlights/AcousticSpotlight

const CHANGE_COOLDOWN_MAX: float = 3.0
const CAMERA_SPEED: float = 200


func _enter_tree():
	var authority_id = 1 # Always the server ID.

	set_multiplayer_authority(authority_id)

	if authority_id != multiplayer.multiplayer_peer.get_unique_id():
		set_process(false)
		set_physics_process(false)
		set_process_input(false)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	change_cooldown = clampf(change_cooldown - delta, 0.0, CHANGE_COOLDOWN_MAX)

func _physics_process(_delta: float) -> void:
	if is_active:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_direction * CAMERA_SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func change_mask(new_mask) -> void:
	if change_cooldown != 0:
		return

	if state_machine.transition_mask(new_mask):
		change_cooldown = CHANGE_COOLDOWN_MAX

func _on_player_detector_area_exited(_area: Area2D) -> void:
	print("AREA IS NO LONGER DETECTED!")
	player_detected = true

func _on_player_detector_area_entered(_area: Area2D) -> void:
	print("AREA HAS BEEN DETECTED!")
	player_detected = false


func _on_player_not_detected(_body: Node2D) -> void:
	print("PLAYER IS NO LONGER DETECTED!")
	player_detected = true
	pass # Replace with function body.

func _on_player_detected(_body: Node2D) -> void:
	print("PLAYER HAS BEEN DETECTED!")
	player_detected = false
	pass # Replace with function body.

