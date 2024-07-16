extends Node3D


# Called when the node enters the scene tree for the first time.
func gun_setup(gun):
	var stats = {
		"Chamber Time": -3
	}
	return stats
func onhit(body, enchant_damp):
	if body is RigidBody3D:
		body.apply_central_force(global_transform.basis.z * Vector3(1000/2, 0, 1000/2) + Vector3(0, 5000/2, 0))
