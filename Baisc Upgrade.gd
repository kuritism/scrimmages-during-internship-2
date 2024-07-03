extends Node3D


func setup(bullet):
	bullet.bullet_damage += 30
	bullet.bullet_speed -= 10
func onhit(body):
	print("ARGGHGHGHHGH")
