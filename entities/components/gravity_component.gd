class_name GravityComponent
extends EntityComponent

@export_group("Gravity Settings")
@export var gravity : float = 750
#Is falling setter and getter
@export var falling : bool = false:
	set(new_value):
		if falling != new_value:
			falling = new_value
			if Debug.debug:
				print(parent, " - Is Falling : ", falling)

#Handles parent gravity based on gravity and sets the falling flag
func handle_gravity(delta : float, entity : Entity = parent) -> void:
	if !entity.is_on_floor():
		var movement : float = entity.velocity.y + gravity * delta
		entity.velocity.y = movement
	falling = true if entity.velocity.y > 0 else false
