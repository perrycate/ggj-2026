extends CharacterBody2D

@onready var camera_node: Camera2D = $Camera2D

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	print("player authority: ", name)

func _ready():
	if is_multiplayer_authority():
		print("just the player")
		camera_node.enabled = true
		
	pass
