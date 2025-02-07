class_name Player
extends Entity

func _on_ready() -> void:
	set_multiplayer_authority(peer_id)
