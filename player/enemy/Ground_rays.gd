extends Node2D
onready var left = false
onready var right = false

func _process(delta):
	left = $Left_ray.is_colliding()
	right = $Right_ray.is_colliding()

func _is_valid_dir(dir):
	if dir < 0:
		return left
	elif dir > 0:
		return right
