extends Node3D
var bullet = null
var bullet_clone = null
var time = 0
var osolations = 2
var dist = 0.2
var axis = Vector3(0, 0, 0)
var change = Vector3(0, 0, 0)
var inital = Vector3(0, 0, 0)
# Use to support Helix enchant

func bullet_setup(bullet_obj, enchant_damp):
	bullet = bullet_obj
	dist = bullet_obj.stats["Bullet Speed"] / 2
	
func _physics_process(delta):
	if !axis:
		if bullet:
			var v1 = bullet.get_linear_velocity()
			axis = (Vector3(0, 1, 0)).cross(v1).normalized()
			change = (Vector2(v1.x, v1.z).angle() - 1.57)
		return
	if !inital:
		inital = bullet.position
		bullet.apply_central_force(Vector3(cos(change), 0, sin(change)) * -100 * dist)
	var v2 = bullet.position - inital
	var dist_from_axis = axis.dot(v2) * 10
	bullet.apply_central_force(Vector3(cos(change), 0, sin(change)) * dist * -dist_from_axis)
