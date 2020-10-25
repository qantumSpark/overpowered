extends KinematicBody2D

onready var speed = 10
onready var max_speed = 30
onready var jump_force = 200
onready var gravity = 25
onready var dir = 1

onready var state_machine = $StatesMachine
onready var ground_ray = $Ground_rays
onready var aggro_zone = $AggroZone
var motion = Vector2()
var state
var target = null
var is_knockback = false
var knockback_force 
var health = 20

func _physics_process(_delta):

	state = state_machine.current_state
	if health <= 0:
		queue_free()
	debug_display()

func _apply_gravity():
	motion.y += gravity
	if motion.y > 300:
		motion.y = 300

func _move():
	
	motion.x = lerp(motion.x, motion.x + speed * dir, 0.7)
	motion.x = lerp(motion.x, 0, 0.2)
	
	if abs(motion.x) > max_speed and !is_knockback:
		motion.x = max_speed * dir
	elif is_knockback:
		knockback(knockback_force)

		


func _get_target_dir():
	var t_pos = target.position

	if t_pos.x > position.x :
		return 1
	elif t_pos.x < position.x :
		return -1

func _is_valid_dir():
	return ground_ray._is_valid_dir(dir)
	

func _flip_dir():
	dir = dir * -1

func debug_display():
	$Debug/VBoxContainer/sword_angle.text = "State: " + state
	$Debug/VBoxContainer/jump_count.text = "motion: " + str(motion)
	if target == null :
		$Debug/VBoxContainer/State.text = "target: " + var2str(target)
	else:
		$Debug/VBoxContainer/State.text = "target: " + var2str(target.name)

func hit(dammage):
	health -= dammage
	

func knockback(kb):
	$ColorRect.color = Color(1,0,0,1)
	motion.x += knockback_force * -dir
	motion.y -= 20

func _on_Hurtbox_area_entered(area):
	var attacker = area.get_parent().get_parent().get_parent()
	if attacker.name == "Player":
		var dmg = attacker._get_dammage()
		var _knockback = attacker._get_knockback()
		hit(dmg)
		knockback_force = _knockback
		is_knockback = true
		$Timer.start(0.2)
		


func _on_Timer_timeout():
	$ColorRect.color = Color(1,1,1,1)
	is_knockback = false
