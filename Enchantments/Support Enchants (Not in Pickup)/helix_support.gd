extends Node3D
var bullet = null
var bullet_clone = null
var time = 0
var osolations = 2
var dist = 0.2
var dir = null
# Use to support Helix enchant

func bullet_setup(bullet_obj, enchant_damp):
	bullet = bullet_obj
	osolations = bullet_obj.stats["Bullet Speed"] / 4
	dist = osolations / 30
	
func _physics_process(delta):
	if !dir:
		if bullet:
			dir = bullet.get_linear_velocity()
		return
	var change = Vector2(dir.x, dir.z).angle() + 1.57 * sign(cos(3.14 * osolations * time)) * pow(abs(dist * (1 + cos(3.14 * osolations * time + 1.57))), 0.5)
	bullet.apply_central_force(Vector3(cos(change) * dist, 0, sin(change) * dist)* 1000)
	time += delta
	print("Bullet 2")
	
