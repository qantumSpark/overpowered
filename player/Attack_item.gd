extends Node2D

onready var Pivot = $Pivot
onready var H_ray = $H_ray
onready var anim_player = $Pivot/AnimationPlayer
onready var item


func _ready():
	item = Pivot.get_child(0)

func _process(delta):
	var target = cast_to_mouse()
	var angle = target.angle()
	Pivot.rotation = angle
	set_layer(angle)
	

func set_layer(angle):
	if angle > -1.5 and angle < 1.5:
		Pivot.z_index = 2
	else:
		Pivot.z_index = -10
	
func cast_to_mouse():
	var m_pos = get_local_mouse_position() - position
	H_ray.cast_to = m_pos
	return m_pos
