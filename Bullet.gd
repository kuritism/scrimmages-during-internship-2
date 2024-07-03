extends RigidBody3D

@onready var bullet_speed : int = 50
@onready var bullet_damage : int = 10
@onready var bullet_spread : float
@onready var hp_comp = preload("res://HP.tscn")
@onready var enchantments = null
func setup(gun_basis, enchants):
	enchantments = enchants
	for enchant in enchantments.get_children():
		if enchant.has_method("bullet_setup"):
			print("Ding dong")
			enchant.bullet_setup(self)
			print(bullet_damage)
	
	var height = (bullet_speed - (bullet_speed % 10))/10 + 1
	$Area3D/CollisionShape3D.shape.height = height
	$Area3D/CollisionShape3D.position.z = (height - 1) * 0.125
	$Area3D/CollisionShape3D.disabled = false
	apply_central_force(gun_basis * bullet_speed * 30)
	


func _on_area_3d_body_entered(body):
	if body.has_node("HP"):
		var hp = body.get_node("HP")
		print("Da damage: " + str(bullet_damage))
		hp.take_damage(bullet_damage)
	for enchant in enchantments.get_children():
		if enchant.has_method("onhit"):
			enchant.onhit(body)
	queue_free()
