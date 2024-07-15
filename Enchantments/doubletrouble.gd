extends Node3D
@onready var instancedBull = preload("res://Bullet.tscn")
@onready var root = get_tree().get_root()  
@onready var bullet = null
func gun_setup(gun):
	var stats = {
		"Chamber Time": 10,
		"Bullet Speed": -5
	}
	return stats
func bullet_setup(bullet_obj, enchant_damp):
	bullet = bullet_obj
	$"Status Effect".start()

func _on_status_effect_timeout():
	var mini_bullet = instancedBull.instantiate()
	var mini_bullet_stats = bullet.stats.duplicate()
	var stat_changes = $Enchantments/Miniaturize.gun_setup(null)
	for i in stat_changes:
		mini_bullet_stats[i] += stat_changes[i]
	print(mini_bullet_stats)
	bullet.add_child(mini_bullet)
	mini_bullet.setup(bullet.global_transform.basis.z, $Enchantments.get_children(), mini_bullet_stats)
	mini_bullet.reparent(root)
	mini_bullet.position.x=bullet.position.x
	mini_bullet.position.y=bullet.position.y
	mini_bullet.position.z=bullet.position.z
	

