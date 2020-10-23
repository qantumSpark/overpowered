extends Node

onready var Parent = get_parent()
var state = idle
var previous_state = null

var wall_side
var previous_wall_side
var can_jump = true
var jump_count = 2
enum {
	idle,
	run,
	jump,
	fall,
	wall
}

func _physics_process(delta):
	_state_logic()
	Parent._apply_gravity()
	_apply_state()
	Parent._move()
	
	if jump_count < 2 :
		if state == wall:
			var side = Parent._get_wall_side()
			jump_count += 1
			
		if state == idle or state == run:
			jump_count += 1
	

func set_state(new_state):
	previous_state = state
	state = new_state
	
func _apply_state():
	var jump_ask = Input.is_action_just_pressed("jump")
	var dir = Parent._get_direction()
	var friction = lerp(Parent.motion.x, 0, 0.3)
	var h_move = lerp(Parent.motion.x, Parent.motion.x + Parent.speed * dir, 0.8)
	match state:
		
		idle:
			Parent.motion.x -= friction
			
		run:
			Parent.motion.x += h_move
			
		jump:
			if jump_count !=0 :
				if jump_ask and can_jump:
					can_jump = false
					jump_count -= 1
					Parent.motion.y = Parent.jump_force
					$Timer.start(.3)
			Parent.motion.x += h_move
		fall:
			Parent.motion.x += h_move
			
		wall:
			Parent.motion.y = 25
			Parent.motion.x += h_move
	
	if abs(Parent.motion.x) > Parent.max_speed:
		Parent.motion.x = Parent.max_speed * dir

#Update la state en fonction du context
func _state_logic():
	var dir = Parent._get_direction()
	var jump_ask = Input.is_action_just_pressed("jump")
	
	match state:
		idle:
			if jump_ask and can_jump:
				set_state(jump)
			elif dir != 0:
				set_state(run)
			elif Parent.motion.y > 0:
				set_state(fall)
		run:
			if jump_ask and can_jump:
				set_state(jump)
			elif dir == 0:
				set_state(idle)
			elif Parent.motion.y > 0:
				set_state(fall)
		jump:
			if Parent.motion.y > 0:
				set_state(fall)
			elif Parent._is_walled():
				set_state(wall)
		fall:
			if jump_ask and can_jump:
				set_state(jump)
			elif Parent._is_walled():
				set_state(wall)
			elif Parent.motion.y == 0:
				set_state(idle)
		wall:
			if jump_ask:
				set_state(jump)
			elif Parent.motion.x != 0:
				set_state(fall)
			elif Parent.is_on_floor():
				set_state(idle)


func _on_Timer_timeout():
	can_jump = true
	#jump_count = 1

func _get_jump_count():
	return var2str(jump_count)

func _get_state():
	match state :
		idle:
			return " idle "
		run:
			return " run "
		jump:
			return " jump "
		fall:
			return " fall "
		wall:
			return " wall "
		
