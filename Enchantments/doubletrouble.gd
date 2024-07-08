extends Node3D
@onready var instancedBull = preload("res://Bullet.tscn")
@onready var root = get_tree().get_root()  
@onready var bullet = null
func bullet_setup(bullet_obj, enchant_damp):
	bullet = bullet_obj
	$"Status Effect".start()

func _on_status_effect_timeout():
	var mini_bullet = instancedBull.instantiate()
	mini_bullet.bullet_damage = bullet.bullet_damage
	mini_bullet.bullet_speed = bullet.bullet_speed
	bullet.add_child(mini_bullet)
	mini_bullet.setup(bullet.global_transform.basis.z, $Enchantments)
	mini_bullet.reparent(root)
	mini_bullet.position.x=bullet.position.x
	mini_bullet.position.y=bullet.position.y
	mini_bullet.position.z=bullet.position.z
	

