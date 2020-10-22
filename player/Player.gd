extends KinematicBody2D

onready var Anim_player = $AnimationPlayer
onready var _Sprite = $Sprite
onready var ground_ray = $Ground_ray
onready var wall_left_ray = $Wall_left_ray
onready var wall_right_ray = $Wall_right_ray


export (int) var gravity = 20
export (int) var speed = 50
export (int) var max_speed = 150
export (int) var jump_force = -400


var motion = Vector2()

var is_dragging = false

func _physics_process(delta):
	_animate()
	attack_handler()
	

func _is_walled():
	if wall_left_ray.is_colliding() or wall_right_ray.is_colliding():
		return true
	else:
		return false

func _get_wall_side():
	if wall_left_ray.is_colliding():
		return "left"
	elif wall_right_ray.is_colliding():
		return "right"
	else:
		return null
func _get_direction():
	var left = Input.is_action_pressed("left")
	var rigth = Input.is_action_pressed("right")
	var dir = int(rigth) - int(left)
	return dir

func attack_handler():
	if Input.is_action_just_pressed("attack"):
		$Attack_item/Pivot/Sprite.visible = true
		$Attack_item/Pivot/Sprite/slash_anim.play("slash")
		$Attack_item.anim_player.play("slash")
		yield(get_tree().create_timer(0.2), "timeout")
		$Attack_item.anim_player.play("idle")
		yield(get_tree().create_timer(0.2), "timeout")
		$Attack_item/Pivot/Sprite.visible = false


func _move():
	motion = move_and_slide(motion, Vector2.UP)


func _can_jump():
	if wall_left_ray.is_colliding() or wall_right_ray.is_colliding() or ground_ray.is_colliding():
		return true
	else :
		return false


func _animate():
	
	if ground_ray.is_colliding():
		if round(motion.x) == 0 and round(motion.y) ==0:
			#idle
			Anim_player.play("idle")
		elif motion.x > 0:
			# to the right
			_Sprite.flip_h = false
			Anim_player.play("run")
		elif motion.x < 0:
			# to the left
			_Sprite.flip_h= true
			Anim_player.play("run")
			
	else:
		#jumping
		Anim_player.play("jump")

#Gère la gravitéS
func _apply_gravity():
	motion.y += gravity
	if motion.y > 300:
		motion.y = 300




