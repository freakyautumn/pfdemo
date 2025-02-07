class_name EntityComponent
extends Node

@export_group("Debug Settings")
@export var debug_color : String = "white"

#Parent setter and getter
@export var parent : Entity:
	set(new_value):
		if parent != new_value:
			parent = new_value
			if Debug.debug:
				print(self, " - Set Parent : ", parent)
