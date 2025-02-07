class_name MoveComponent
extends EntityComponent

@export_group("Movement Settings")
@export var speed : float = 220
@export var acceleration : float = 900
@export var air_acceleration : float = 500
@export var affected_by_knockback : bool = true

#Handles the horizontal movement
func handle_horizontal_movement(delta : float, entity : Entity = parent) -> void:
	var input : float = entity.input_component.horizontal_input #Determine input
	var acceleration_mod : float = acceleration if entity.is_on_floor() else air_acceleration #Modify acceleration if entity is in the air
	var movement : float = move_toward(entity.velocity.x, speed * input, acceleration_mod * delta) #Calculate movement
	entity.velocity.x = movement #Apply movement

#Applies knockback backed on the attack origin from the passed in Attack
func apply_knockback(attack : Attack, entity : Entity = parent) -> void:
	var knockback_vector : Vector2 = entity.global_position - attack.attack_position #Calculate knockback
	if affected_by_knockback: entity.velocity += knockback_vector.normalized() * attack.knockback_force #Apply knockback
