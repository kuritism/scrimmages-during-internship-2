extends Node3D


# Called when the node enters the scene tree for the first time.
func gun_setup(gun):
	var stats = {
		"Bullet Damage": -10,
		"Bullet Speed": 10,
	}
	return stats
func bullet_setup(bullet_obj, enchant_damp):
	bullet_obj.scale *= 0.5
	if bullet_obj.stats["Bullet Life"] > 1:
		bullet_obj.stats["Bullet Life"] = 1
