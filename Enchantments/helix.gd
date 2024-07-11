extends Node3D
var bullet = null
var bullet_clone = null
var time = 0
var osolations = 2
var dist = 0.2
func gun_setup(gun):
	var stats = {
		"Bullet Speed": 5,
		"Bullet Life": 3
	}
	return stats

func bullet_setup(bullet_obj, enchant_damp):
	bullet_obj.stats["Bullet Damage"] /= 1.5
	bullet_clone = bullet_obj.duplicate()
	bullet = bullet_obj
	bullet.add_child(bullet_clone)
	print(get_path())
	bullet_clone.get_node("./Enchantments/Helix").queue_free()
	osolations = bullet_obj.stats["Bullet Speed"] / 4
	print("Os")
	print(osolations)
	dist = osolations / 30
	
	bullet_clone.setup(bullet.global_transform.basis.z, null, bullet.stats)
	print(bullet_clone)
	
func _physics_process(delta):
	if bullet:
		var dir = bullet.get_linear_velocity()
		dir = Vector2(dir.x, dir.z).angle() + deg_to_rad(90) * cos(3.14 * osolations * time)/abs(cos(3.14 * osolations * time))
		bullet.position.x += cos(dir) * dist
		bullet.position.z += sin(dir) * dist
	if bullet_clone:
		var dir = bullet_clone.get_linear_velocity()
		dir = Vector2(dir.x, dir.z).angle() - deg_to_rad(90) * cos(3.14 * osolations * time)/abs(cos(3.14 * osolations * time))
		bullet_clone.position.x += cos(dir) * dist
		bullet_clone.position.z += sin(dir) * dist
	time += delta
	
