extends CharacterBody2D

var life_timer: float = LIFE_TIME  # seconds

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")

# CT: TOOD: fine tune this
const CHASE_SPEED: float = 80.0

const LIFE_TIME: float = 3.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	life_timer = clampf(life_timer - delta, 0.0, LIFE_TIME)
	if life_timer == 0:
		queue_free()

func _physics_process(_delta: float) -> void:
	# chase the player down
	var direction = position.direction_to(player.position)
	velocity = direction * CHASE_SPEED
	move_and_slide()

func _on_player_body_entered(_body: Node2D) -> void:
	print("drone has hit player")
	queue_free()
	#CT: TODO: some sort of player damage


