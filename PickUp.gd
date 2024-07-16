extends MeshInstance3D

func _on_area_3d_body_entered(body):
	if body.has_method("on_enchant_pickup"):
		body.on_enchant_pickup($Enchant.get_child(0))
		queue_free()
