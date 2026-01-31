extends CharacterBody2D

@onready var camera_node: Camera2D = $Camera2D
@onready var sprite: AnimatedSprite2D = $PlayerSprite

func _enter_tree():
	set_multiplayer_authority(name.to_int())

	# Dirty hack, open to suggestions.
	position = $"../PlayerSpawnPoint".position

func _ready():
	if is_multiplayer_authority():
		camera_node.enabled = true
	pass
