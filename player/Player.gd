extends KinematicBody2D

#onready var Anim_player = $AnimationPlayer
onready var _Sprite = $Sprite
onready var ground_ray = $Ground_ray
onready var wall_left_ray = $Wall_left_ray
onready var wall_right_ray = $Wall_right_ray


export (int) var gravity = 25
export (int) var speed = 70
export (int) var max_speed = 170
export (int) var jump_force = -500

var dir = 0
var motion = Vector2()

var is_dragging = false

func _physics_process(delta):
	check_direction()
	_update_hit_box()
	debug_display()
	pass

# MOTION

# 	Applique la gravité
func _apply_gravity():
	motion.y += gravity
	if motion.y > 300:
		motion.y = 300

# Applique le mouvement
func _move():
	motion = move_and_slide(motion, Vector2.UP)


# CONTEXT & INPUTS

#Flip l'image en fonction de la direction
func check_direction():
	if dir == 1:
		_Sprite.flip_h = false
	elif dir == -1:
		_Sprite.flip_h = true
		
	if $StateMachine._get_state() == "wall":
		if _get_direction() == 1:
			 _Sprite.flip_h = true
		elif _get_direction() == -1:
			_Sprite.flip_h = false

# Retourne la direction en fonction des inputs
func _get_direction():
	var left = Input.is_action_pressed("left")
	var rigth = Input.is_action_pressed("right")
	var dir = int(rigth) - int(left)
	return dir

#Check si le player peut sauter
func _can_jump():
	if wall_left_ray.is_colliding() or wall_right_ray.is_colliding() or ground_ray.is_colliding():
		return true
	else :
		return false

#Check si le player est en contact avec un mur
func _is_walled():
	if wall_left_ray.is_colliding() or wall_right_ray.is_colliding():
		return true
	else:
		return false

#Retourne la direction du mur en contact avec le player
func _get_wall_side():
	if wall_left_ray.is_colliding():
		return "left"
	elif wall_right_ray.is_colliding():
		return "right"
	else:
		return null

# ACTIONS & INTERACTIONS
func _get_dammage():
	var dmg = 5
	return dmg
	
func _get_knockback():
	var kb = 50
	return kb

func _update_hit_box():
	$Hand/Pivot/Hitbox/CollisionShape2D.disabled = true
	if Input.is_action_just_pressed("attack"):
		print("Attack!")
		$Hand/Pivot/Hitbox/CollisionShape2D.disabled = false
	
func debug_display():
	$Debug/VBoxContainer/sword_angle.text = "Sword_angle: " + var2str(rad2deg($Hand/Pivot.rotation))
	$Debug/VBoxContainer/State.text = "State: " + $StateMachine._get_state()
	$Debug/VBoxContainer/jump_count.text = "Jump Counter: " + $StateMachine._get_jump_count()





