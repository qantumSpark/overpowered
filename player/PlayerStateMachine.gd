extends "res://StateMachine.gd"

func ready():
	print("hey")
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("wall")
	call_deferred("set_state", states.idle)

func _state_logic(delta):
	Parent._handle_movement()
	Parent._apply_gravity()
	Parent._apply_movement()

func _get_transition(delta):
	
	match state:
		states.idle:
			if !Parent.is_on_floor():
				if Parent.motion.y < 0:
					return states.jump
				elif Parent.motion.y > 0:
					return states.fall
			elif Parent.motion.x != 0:
					return states.run
		states.run:
			if !Parent.is_on_floor():
				if Parent.motion.y < 0:
					return states.jump
				elif Parent.motion.y > 0:
					return states.fall
			elif Parent.motion.x == 0:
					return states.idle
		states.jump:
			if Parent.is_on_floor():
				return states.idle
			elif Parent._is_walled():
				return states.wall
			elif Parent.motion.y > 0:
				return states.fall
		states.fall:
			if Parent.is_on_floor():
				return states.idle
			elif Parent._is_walled():
				return states.wall
	
	return states.idle

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
