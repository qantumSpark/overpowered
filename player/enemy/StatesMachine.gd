extends Node

onready var parent = get_parent()

onready var idle = $Idle
onready var walk = $Walk
onready var chase = $Chase
onready var hurt = $Hurt

var states_map = {}

var states_stack = []
var current_state = null


func _ready():
	states_map = {
		"idle": idle,
		"walk": walk,
		"chase": chase,
		"hurt": hurt
	}
	current_state = "walk"

func _physics_process(delta):
	states_map.get(current_state).update(delta)
	pass

func update():
	match current_state:
		"idle":
			pass
		"walk":
			pass
		"chase":
			pass
		"hurt":
			pass

func _change_state(state_name):
	
	if state_name == current_state:
		return
	states_stack.push_front(state_name)
	current_state = state_name
	if states_stack.size() > 2:
		states_stack.pop_back()
	states_map.get(current_state).enter()


func _on_AggroZone_body_entered(body):
	
	parent.target = body
	_change_state("chase")


func _on_AggroZone_body_exited(body):
	
	parent.target = null
	_change_state("walk")
