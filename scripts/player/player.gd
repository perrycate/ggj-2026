extends CharacterBody2D

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	print("player authority: ", name)
	print(position)
	print(global_position)

func _ready():
	pass
