extends Node2D
#TODO: Do not use this script. This is temp, meant to be refactored
@onready var player: Player = $Player #TODO: Fix this
@onready var player_spawner: MultiplayerSpawner = $PlayerSpawner
@onready var player_node: Node2D = $PlayerSpawner/PlayerNode
@onready var cursor: Area2D = $Cursor

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		for body in cursor.get_overlapping_bodies():
			if body is not Player: continue
			var attack = Attack.new()
			attack.damage_amount = 5
			attack.knockback_force = 250
			attack.attack_position = get_global_mouse_position()
			if multiplayer.is_server():
				body.damage(attack)

func _process(delta: float) -> void:
	cursor.global_position = get_global_mouse_position()
