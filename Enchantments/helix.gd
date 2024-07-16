extends Node3D
var bullet = null
var bullet_clone = null
var helix_support = preload("res://Enchantments/Support Enchants (Not in Pickup)/helix_support.tscn")
var instancedBull = preload("res://Bullet.tscn")
var time = 0
var osolations = 2
var dist = 0.2
var axis = Vector3(0, 0, 0)
var change = Vector3(0, 0, 0)
var inital = Vector3(0, 0, 0)
func gun_setup(gun):
	var stats = {
		"Bullet Speed": 5,
		"Bullet Life": 3
	}
	return stats
 
func bullet_setup(bullet_obj, enchant_damp):
	bullet_obj.stats["Bullet Damage"] /= 1.5
	bullet_clone = instancedBull.instantiate()
	var clone_enchants = bullet_obj.get_node("./Enchantments").duplicate()
	bullet = bullet_obj
	bullet.add_child(bullet_clone)
	var set_for_removal = clone_enchants.get_node("./Helix")
	clone_enchants.remove_child(set_for_removal)
	set_for_removal.queue_free()
	
	clone_enchants.add_child(helix_support.instantiate())
	dist = bullet_obj.stats["Bullet Speed"] / 2
	
	bullet_clone.setup(bullet.global_transform.basis.z, clone_enchants.get_children(), bullet.stats)
	bullet_clone.stats = bullet.stats
	
func _physics_process(delta):
	if !axis:
		if bullet:
			var v1 = bullet.get_linear_velocity()
			axis = (Vector3(0, 1, 0)).cross(v1).normalized()
			change = (Vector2(v1.x, v1.z).angle() - 1.57)
		return
	if !inital:
		inital = bullet.position
		bullet.apply_central_force(Vector3(cos(change), 0, sin(change)) * 100 * dist)
	var v2 = bullet.position - inital
	var dist_from_axis = axis.dot(v2) * 10
	bullet.apply_central_force(Vector3(cos(change), 0, sin(change)) * dist * -dist_from_axis * 5)

	
