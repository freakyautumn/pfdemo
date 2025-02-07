class_name  HealthComponent
extends EntityComponent

@export_group("Health Settings")
#Horizontal Input setter and getter
@export var max_health : int = 100
@export var health : int:
	set(new_value):
		if health != new_value:
			health = clampi(new_value, 0, max_health)
			if Debug.debug:
				print_rich("[color=",debug_color,"]",parent, " - Health : [/color]",health)

func damage(attack : Attack) -> void:
	health -= attack.damage_amount
