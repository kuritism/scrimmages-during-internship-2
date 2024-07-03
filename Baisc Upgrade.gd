extends Node3D


func bullet_setup(bullet):
	bullet.bullet_damage += 30
	bullet.bullet_speed -= 10
func onhit(body):
	print("ARGGHGHGHHGH")
