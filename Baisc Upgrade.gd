extends Node3D


@onready var bullet = null
func gun_setup(gun):
	var stats = {
		"Bullet Damage": -5,
		"Bullet Speed": -15,
		"Bullet Life": 3
	}
	return stats
func bullet_setup(bullet_obj, enchant_damp):
	bullet = bullet_obj
	$"Status Effect".start()
	

func onhit(body, enchant_damp):
	pass


func _on_timer_timeout():
	bullet.stats["Bullet Damage"] += 5
