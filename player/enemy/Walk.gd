extends Node

onready var Enemy = get_parent().get_parent()

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
	
	Enemy._apply_gravity()
	if Enemy._is_valid_dir():
		Enemy._move()
	else: 
		Enemy._flip_dir()
	Enemy.move_and_slide(Enemy.motion, Vector2.UP)


func _on_animation_finished(_anim_name):
	pass
