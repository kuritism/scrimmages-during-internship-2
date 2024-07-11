extends Node3D
var bullet = null
func gun_setup(gun):
	var stats = {
		"Bullet Speed": -10,
		"Bullet Damage": 10,
		"Bullet Life": 5,
	}
	return stats
	
func bullet_setup(bullet_obj, enchant_damp):
	bullet = bullet_obj
	bullet_obj.gravity_scale = 1

func _physics_process(_delta):
	if bullet:
		bullet.look_at(bullet.position - bullet.get_linear_velocity(), Vector3.UP)
