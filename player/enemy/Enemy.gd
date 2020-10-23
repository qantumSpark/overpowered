extends KinematicBody2D

onready var speed = 25
onready var max_speed = 30
onready var jump_force = 200
onready var gravity = 25
onready var dir = 1

onready var state_machine = $StatesMachine
onready var ground_ray = $Ground_rays
onready var aggro_zone = $AggroZone
var motion = Vector2()
var state

func _physics_process(_delta):

	pass



func _apply_gravity():
	motion.y += gravity
	if motion.y > 300:
		motion.y = 300

func _move():
	motion.x = lerp(motion.x, motion.x + speed * dir, 0.7)
	motion.x = lerp(motion.x, 0, 0.2)
	if abs(motion.x) > max_speed:
		motion.x = max_speed * dir
	

func _is_valid_dir():
	#print("dir:", dir)
	#print("is valid", ground_ray._is_valid_dir(dir))
	#print("==========================")
	return ground_ray._is_valid_dir(dir)
	

func _flip_dir():
	dir = dir * -1


