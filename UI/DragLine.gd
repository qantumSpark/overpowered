extends Node2D


onready var Line = $Line2D
onready var Ray =$RayCast2D

var is_dragging = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if Line.visible:
		Line.visible = false

func init():
	pass
	
func _process(delta):
	var mouse_pos = get_local_mouse_position() - position
	
	if Input.is_action_just_pressed("dash"):
		
		is_dragging = true
		Line.visible = true
		if Line.get_point_count() != 0:
			pass
		else:
			Line.add_point(get_local_mouse_position() - position)
	
	if Input.is_action_pressed("dash") and is_dragging:

		if Line.get_point_count() == 1:
			Line.add_point(mouse_pos)
		if is_dragging == true:
			Line.set_point_position(1, mouse_pos)

	if Input.is_action_just_released("dash"):
		Line.clear_points()
		Line.visible = false
		is_dragging = false
