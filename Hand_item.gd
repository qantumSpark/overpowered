extends Node2D

func slash():
	#Declenche the slashing logic
	$AnimationPlayer.play("slash")
	pass

func flip():
	$Sword.flip_v = ! $Sword.flip_v
	if $Sword.flip_v:
		$Sword.position.x = -20
