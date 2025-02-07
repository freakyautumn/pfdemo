class_name Entity
extends CharacterBody2D

@export_group("Components")
@export var input_component : InputComponent
@export var move_component : MoveComponent
@export var jump_component : JumpComponent
@export var gravity_component : GravityComponent
@export var health_component : HealthComponent

# Multiplayer ID
@export_group("Network")
@export var peer_id : int = 1

#Called when the node is loaded
func _ready() -> void:
	#Sets the component parents
	if input_component: input_component.parent = self
	if move_component: move_component.parent = self
	if jump_component: jump_component.parent = self
	if gravity_component: gravity_component.parent = self
	if health_component: health_component.parent = self
	#Connects to _on_ready()
	self.ready.connect(_on_ready)

func _on_ready() -> void: pass

#Called each physics frame
func _physics_process(delta: float) -> void:
	if input_component: input_component.handle_inputs()
	if jump_component: jump_component.handle_jump()
	if gravity_component: gravity_component.handle_gravity(delta)
	if move_component: move_component.handle_horizontal_movement(delta)
	
	#Do the physics calculations
	move_and_slide()

#Called to damage this body
func damage(attack : Attack = Attack.new()) -> void:
	if health_component: health_component.damage.rpc_id(peer_id, attack)
	if move_component: move_component.apply_knockback.rpc_id(peer_id, attack)
