class_name InputComponent
extends EntityComponent

@export_group("Input Settings")
#Horizontal Input setter and getter
@export var jump_buffer_time : float = 0.1
@export var horizontal_input : float = 0:
	set(new_value):
		if horizontal_input != new_value:
			horizontal_input = new_value
			if Debug.debug:
				print_rich("[color=",debug_color,"]",parent, " - X Input : [/color]",horizontal_input)

#Jump Input setter and getter
@export var jump_input : float = 0:
	set(new_value):
		if jump_input != new_value:
			jump_input = new_value
			if Debug.debug:
				print_rich("[color=",debug_color,"]",parent, " - Jump Input : [/color]",jump_input)

#Buffer timer
var jump_buffer_timer : Timer

#Sets up the buffer timer
func start_jump_buffer() -> void:
	jump_buffer_timer = Timer.new()
	add_child(jump_buffer_timer)
	jump_buffer_timer.start(jump_buffer_time)
	jump_buffer_timer.timeout.connect(_on_jump_buffer_timer_timeout)

#Calls all the inputs
func handle_inputs() -> void:
	handle_horizontal_input()
	handle_jump_input()

#Handles getting horizontal input
func handle_horizontal_input() -> void:
	horizontal_input = Input.get_axis("move_left", "move_right")

#Hanldes jump input
func handle_jump_input() -> void:
	if jump_buffer_timer != null: return
	elif Input.is_action_just_pressed("jump"):
		jump_input = true
		start_jump_buffer()

#Runs when the buffer timer times out
func _on_jump_buffer_timer_timeout() -> void:
	jump_buffer_timer.queue_free()
	jump_input = false
