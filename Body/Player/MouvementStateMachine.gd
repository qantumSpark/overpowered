extends Node

onready var parent = get_parent()

onready var Idle = $Idle
onready var Run = $Run
onready var Jump = $Jump
onready var Fall = $Fall
onready var WallSlide = $WallSlide
onready var Dash = $Dash

var states_map = {}

var states_stack = []
var current_state = null


func _ready():
	states_map = {
		"Idle": Idle,
		"Run": Run,
		"Jump": Jump,
		"Fall": Fall,
		"WallSlide": WallSlide,
		"Dash": Dash
	}
	_change_state("Idle") 

func _physics_process(delta):
	update()
	states_map.get(current_state).update(delta)
	#print(current_state)


func update():
	match current_state:
		"Idle":
			if parent.motion.y < -1:
				_change_state("Jump")
			elif parent.motion.y > 0 and !parent.is_grounded():
				_change_state("Fall")
			elif parent.dir != 0:
				_change_state("Run")
		"Run":
			if parent.motion.y < -1:
				_change_state("Jump")
			elif parent.motion.y > 0 and !parent.is_grounded():
				_change_state("Fall")
			elif parent.dir == 0 :
				_change_state("Idle")
		"Jump":
			if parent.motion.y >= 0:
				_change_state("Fall")
			elif parent.is_against_wall() != 0:
				_change_state("WallSlide")
		"Fall":
			if parent.motion.y < -1:
				_change_state("Jump")
			elif parent.is_against_wall() != 0:
				_change_state("WallSlide")
			elif parent.is_grounded() and parent.dir != 0:
				_change_state("Run")
			elif parent.is_grounded() and !parent.motion.y < 0:
				_change_state("Idle")
		"WallSlide":
			if parent.is_grounded() and parent.dir != 0:
				_change_state("Run")
			elif parent.is_grounded() and !parent.motion.y < 0:
				_change_state("Idle")
			elif parent.motion.y < 0:
				_change_state("Jump")
			elif parent.is_against_wall() == 0:
				_change_state("Fall")
		"Dash":
			pass

func _change_state(state_name):
	if state_name == current_state:
		return
	states_stack.push_front(state_name)
	if current_state != null:
		states_map.get(current_state).exit()
	current_state = state_name
	if states_stack.size() > 2:
		states_stack.pop_back()
	states_map.get(current_state).enter()



