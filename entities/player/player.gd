class_name Player
extends Entity

@export_group("Components")
#@export var input_syncronizer : InputSynchronizer
# Multiplayer ID
@export var peer_id : int = 1

func _on_ready() -> void: input_component.set_multiplayer_authority(peer_id)
