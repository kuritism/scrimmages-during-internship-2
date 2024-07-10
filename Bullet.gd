extends RigidBody3D

@export var stats : Dictionary = {
	"Mag Size": 20,
	"Reload Number": 3,
	"Chamber Time": 3,
	"Reload Time": 10,
	"Bullet Damage": 10,
	"Bullet Speed": 5,
	"Bullet Life": 1,
	"Bullet Spread": 1,
	"Shell Amount": 1
}
@onready var enchantments = null
@onready var enchant_damp = 1
func setup(gun_basis, enchants, gun_stats):
	stats = gun_stats.duplicate()
	if enchants:
		enchantments = enchants.duplicate()
		add_child(enchantments)
		#Math (Bigger Decimal = More Dampening)
		enchant_damp = 0.5 + 0.5*(enchantments.get_child_count())
		if stats["Bullet Damage"] < 5:
			stats["Bullet Damage"] = 5
		if stats["Bullet Speed"] < 5:
			stats["Bullet Speed"] = 1
		
		for enchant in enchantments.get_children():
			if enchant.has_method("bullet_setup"):
				enchant.bullet_setup(self, enchant_damp)
	
	var height = (stats["Bullet Speed"] - (int(round(stats["Bullet Speed"])) % 10))/10 + 1
	$"Area3D/CollisionShape3D".shape.height = height
	$"Area3D/CollisionShape3D".position.z = (height - 1) * 0.125
	$"Area3D/CollisionShape3D".disabled = false
	apply_central_force(gun_basis * stats["Bullet Speed"] * 150)
	$Timer.start(stats["Bullet Life"])

func _on_area_3d_body_entered(body):
	if body.has_node("HP"):
		var hp = body.get_node("HP")
		print("Da damage: " + str(stats["Bullet Damage"]))
		hp.take_damage(stats["Bullet Damage"])
	if enchantments:
		for enchant in enchantments.get_children():
			if enchant.has_method("onhit"):
				enchant.onhit(body, enchant_damp)
	queue_free()


func _on_timer_timeout():
	queue_free()
