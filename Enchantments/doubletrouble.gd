extends Node3D

@onready var bullet = null
func bullet_setup(bullet_obj, enchant_damp):
	bullet = bullet_obj
	$"Status Effect".start()
	

func onhit(body, enchant_damp):
	pass


func _on_timer_timeout():
	bullet.bullet_damage += 5
