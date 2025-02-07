class_name Player
extends Entity

# Multiplayer ID
@export var peer_id : int = 1

func _on_ready() -> void:
	set_multiplayer_authority(peer_id)
