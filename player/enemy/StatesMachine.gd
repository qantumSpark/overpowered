extends Node

onready var idle = $Idle
onready var walk = $Walk
onready var chase = $Chase
onready var attack = $Attack

var states_map = {}

var states_stack = []
var current_state = null


func _ready():
	states_map = {
		"idle": idle,
		"walk": walk,
		"chase": chase,
		"attack": attack
	}
	current_state = "walk"

func _physics_process(delta):
	states_map.get("walk").update(delta)
	pass

func update():
	match current_state:
		"idle":
			pass
		"walk":
			pass
		"chase":
			pass
		"attack":
			pass

func _change_state(state_name):
	if state_name == current_state:
		return
	states_stack.push_front(state_name)
	current_state = state_name
	
	if states_stack.size() > 2:
		states_stack.pop_back()


func _on_AggroZone_area_entered():
	print("enter")
	_change_state("chase")


func _on_AggroZone_body_entered(body):
	print("hey")
