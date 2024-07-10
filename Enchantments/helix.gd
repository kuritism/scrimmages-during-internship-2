extends Node3D

func gun_setup(gun):
	var stats = {
		"Bullet Speed": 5,
		"Bullet Life": 3
	}

func bullet_setup(bullet_obj, enchant_damp):
	bullet_obj.stats["Bullet Damage"] /= 1.25
	var bullet = bullet_obj
	
