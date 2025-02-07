class_name JumpComponent
extends EntityComponent

@export_group("Jump Settings")
@export var jump_strength : float = 400
@export var jumping : bool = false:
	set(new_value):
		if jumping != new_value:
			jumping = new_value
			if Debug.debug:
				print(parent, " - Is Jumping : ", jumping)

#Handles jump
func handle_jump(entity : Entity = parent) -> void:
	if entity.is_on_floor() && entity.input_component.jump_input:
		entity.velocity.y -= jump_strength
	jumping = true if entity.velocity.y < 0 else false
