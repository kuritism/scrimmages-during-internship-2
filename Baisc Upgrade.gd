extends Node3D

func bullet_setup(bullet, enchant_damp):
	bullet.bullet_damage -= round(10 / enchant_damp)
	bullet.bullet_speed -= round(10 / enchant_damp)
func bullet_process(bullet, enchant_damp):
	bullet.bullet_damage += round(1 / enchant_damp) + 1
func onhit(body, enchant_damp):
	print("ARGGHGHGHHGH")
