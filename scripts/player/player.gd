extends CharacterBody2D

# Should be set to the peer that has authority over the player,
# beore the player is added to the tree.
var authority_peer_id: int

func _enter_tree():
	set_multiplayer_authority(authority_peer_id)

func _ready():
	pass
