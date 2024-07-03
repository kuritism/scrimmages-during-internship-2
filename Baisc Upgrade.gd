extends Node3D
@onready var bullet = null
func bullet_setup(bullet_obj, enchant_damp):
	bullet = bullet_obj
	bullet.bullet_damage -= round(5 / enchant_damp)
	bullet.bullet_speed -= round(10 / enchant_damp)
	$"Status Effect".start()
	

func onhit(body, enchant_damp):
	pass


func _on_timer_timeout():
	bullet.bullet_damage += 5
