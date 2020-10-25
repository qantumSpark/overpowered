extends Node

onready var parent = get_parent().get_parent()

# Initialisation
func enter():
	#Start animation ici
	parent.speed = 15
	parent.max_speed = 40



# Clean up 
func exit():
	pass


func handle_input(_event):
	pass
	


func update(_delta):
	var target_direction = parent._get_target_dir()
	
	parent._apply_gravity()
	
	if target_direction != parent.dir :
		parent._flip_dir()
	
	parent._move()
	parent.move_and_slide(parent.motion, Vector2.UP)

func _on_animation_finished(_anim_name):
	pass
