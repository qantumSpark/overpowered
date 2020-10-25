extends Node

onready var parent = get_parent().get_parent()
onready var animPlayer = parent.get_node("AnimationPlayer")

# Initialisation
func enter():
	animPlayer.play("WallSlide")

# Clean up 
func exit():
	pass


func update(_delta):
	parent._apply_gravity(parent.GRAVITY)
	parent.motion.y = parent.motion.y / 2
	parent._jump()
	parent.motion.x = lerp(parent.motion.x, 0, 0.3)
	parent.motion.x = lerp(parent.motion.x, parent.motion.x + parent.speed * parent.dir, 0.8)
	parent._move()




