extends Node

onready var parent = get_parent().get_parent()

# Initialisation
func enter():
	#Start animation ici
	pass


# Clean up 
func exit():
	pass


func handle_input(_event):
	
	pass


func update(_delta):
	
	parent._apply_gravity()

	#Check le sol pour déterminer si un changement de direction est nécessaire
	if parent._is_valid_dir():
		parent._move()
	else: 
		parent._flip_dir()
	
	parent.move_and_slide(parent.motion, Vector2.UP)


func _on_animation_finished(_anim_name):
	pass
