extends "res://player/enemy/FSM.gd"

func _ready():
	add_state("sleep")
	add_state("walk")
	add_state("chase")
	add_state("attack")
	call_deferred("set_state", states.sleep)

func _physics_process(delta):
	

func _state_logic(delta):
	
	pass

func _get_transition(delta):
	match states:
		

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
