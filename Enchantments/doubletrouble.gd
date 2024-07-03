extends Node3D

func onhit(body, enchant_damp):
	if body is RigidBody3D:
		body.apply_central_force(global_transform.basis.z * 1000 + Vector3(0, 500, 0))
