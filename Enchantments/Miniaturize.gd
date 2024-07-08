extends Node3D


# Called when the node enters the scene tree for the first time.
func bullet_setup(bullet_obj, enchant_damp):
	bullet_obj.bullet_damage -= round(10 / enchant_damp)
	bullet_obj.bullet_speed += round(100 / enchant_damp)
	bullet_obj.scale *= 0.5
