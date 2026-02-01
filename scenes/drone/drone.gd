extends CharacterBody2D

var timer: float = 3.0  # seconds

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

# CT: TOOD: fine tune this
const CHASE_SPEED: float = 80.0

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	# chase the player down
	var direction = position.direction_to(player.position)
	velocity = direction * CHASE_SPEED
	move_and_slide()

func _on_player_body_entered(_body: Node2D) -> void:
	print("drone has hit player")
	queue_free()
	#CT: TODO: some sort of player damage


