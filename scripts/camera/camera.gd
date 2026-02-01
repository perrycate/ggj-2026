extends CharacterBody2D
class_name Camera

var change_cooldown: float = 0
var is_active: bool = false
var player_detected: bool = false
var detected_player: CharacterBody2D = null

var drone: PackedScene = preload("res://scenes/drone/drone.tscn")
var deployed_drone = null

@onready var state_machine = $StateMachine

@onready var visual_spotlight: Sprite2D = $Spotlights/VisualSpotlight
@onready var infrared_spotlight: Sprite2D = $Spotlights/InfraredSpotlight
@onready var night_vision_spotlight: Sprite2D = $Spotlights/NightVisionSpotlight
@onready var acoustic_spotlight: Sprite2D = $Spotlights/AcousticSpotlight

const CHANGE_COOLDOWN_MAX: float = 3.0
const CAMERA_SPEED: float = 200.0
const DRONE_SPAWN_DISTANCE: float = 150.0


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

	if Input.is_action_just_pressed("drone_deploy") and not deployed_drone and player_detected:
			print("deploying drones!")
			deploy_drones()

func _physics_process(_delta: float) -> void:
	if is_active:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_direction * CAMERA_SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

func deploy_drones():
	var player_angle = global_position.angle_to_point(detected_player.global_position)
	var drone_angle = deg_to_rad(180) + player_angle
	var offset = Vector2(cos(drone_angle), sin(drone_angle)) * DRONE_SPAWN_DISTANCE
	var final_position = position + offset

	deployed_drone = drone.instantiate()
	get_tree().current_scene.add_child(deployed_drone)
	deployed_drone.position = final_position

func change_mask(new_mask) -> void:
	if change_cooldown != 0:
		return

	if state_machine.transition_mask(new_mask):
		change_cooldown = CHANGE_COOLDOWN_MAX

func _on_player_not_detected(_body: Node2D) -> void:
	#print("PLAYER IS NO LONGER DETECTED!")
	player_detected = false
	detected_player = null

func _on_player_detected(_body: Node2D) -> void:
	#print("PLAYER HAS BEEN DETECTED!")
	player_detected = true
	detected_player = _body
