extends KinematicBody2D

onready var jumpTimer = $Timers/JumpCountTimer

export (int) var GRAVITY = 25
#Stats:
export (int) var speed = 70
export (int) var max_speed = 170
export (int) var jump_force = -550
export (int) var max_jump = 2


var jump_count = max_jump
var dir = 0
var flip = false
var motion = Vector2()

func _physics_process(delta):
	check_jump_count()
	_set_direction_from_input()


# DEPLACEMENTS
# Applique la gravité
func _apply_gravity(gravity):
	motion.y = min(motion.y + gravity, 250)

# Déplace le joueur
func _move():
	motion = move_and_slide(motion, Vector2.UP)

# Set la direction en fonction des inputs
func _set_direction_from_input():
	var left = int(Input.is_action_pressed("left"))
	var right = int(Input.is_action_pressed("right"))
	dir = right - left
	update_gfx()
	

# Effectue un jump:
func _jump():
	if Input.is_action_just_pressed("jump") and jump_count > 0:
		
		jump_count -= 1
		motion.y = jump_force
		

#Couldown pour rechargement du double jump:
func check_jump_count():
	if is_grounded() or is_walled():
		if jump_count < max_jump:
			jump_count += 1

# SIGNAL INCOMING
# Jump count rechagement Timer:
func _on_JumpCountTimer_timeout():
	pass

# UTILITY
# Manipulations graphiques
func update_gfx():
	if is_against_wall() == 1:
		$Sprite.flip_h = true
	elif is_against_wall() == -1:
		$Sprite.flip_h = false
	elif dir == 1:
		$Sprite.flip_h = false
	elif dir == -1: 
		$Sprite.flip_h = true



# Retourne la direction
func _get_dir():
	return dir

# Retourne la direction du mur en contact avec le player
func is_against_wall():
	if $Collisions/Rays/WallLeft.is_colliding():
		return -1 #Direction Left
	elif $Collisions/Rays/WallRight.is_colliding():
		return 1 #Direction Right
	else:
		return 0
func is_walled():
	if $Collisions/Rays/WallLeft.is_colliding() or $Collisions/Rays/WallRight.is_colliding():
		return true
	return false
func is_grounded():
	return $Collisions/Rays/Ground.is_colliding()


























