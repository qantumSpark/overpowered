extends Node

onready var parent = get_parent().get_parent()
onready var animPlayer = parent.get_node("AnimationPlayer")

# Initialisation
func enter():
	animPlayer.play("Idle")
	pass

# Clean up 
func exit():
	pass


func update(_delta):
	parent._apply_gravity(parent.GRAVITY)
	parent._jump()
	parent.motion.x = lerp(parent.motion.x, 0, 0.3)
	parent._move()


