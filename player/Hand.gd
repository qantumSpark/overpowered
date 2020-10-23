extends Node2D


onready var Pivot = $Pivot




func _process(delta):
	var ray = get_parent().get_node("RayCast2D")
	ray.set_cast_to(get_local_mouse_position())

	Pivot.rotate(ray.cast_to.angle() - Pivot.rotation)
	if Input.is_action_just_pressed("attack"):
		$Pivot/Sword.slash()
	
	handle_gfx()


func handle_gfx():
	if abs(rad2deg(Pivot.rotation)) > 90:
		if $Pivot.position.x != -14:
			$Pivot/Sword.scale.x = -1
			$Pivot/Sword.rotation_degrees = -110
			$Pivot.position.x = -14
	else:
		if $Pivot.position.x != -7:
			$Pivot/Sword.rotation_degrees = -60
			$Pivot/Sword.scale.x = 1
			$Pivot.position.x = -7
	
	if $Pivot.rotation_degrees < -15 and $Pivot.rotation_degrees > -170:
		$Pivot/Sword.z_index = -1
	else:
		$Pivot/Sword.z_index = 2



