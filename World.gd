extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if $TileMap/Player/DragLine_gfx.is_dragging:
		Engine.set_time_scale(.05)
	else:
		Engine.set_time_scale(1)
