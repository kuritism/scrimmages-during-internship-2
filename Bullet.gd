extends RigidBody3D

@onready var bullet_speed : int = 50
@onready var bullet_damage : int = 10
@onready var bullet_spread : float
@onready var hp_comp = preload("res://HP.tscn")
@onready var enchantments = null
@onready var enchant_damp = 1
func setup(gun_basis, enchants):
	
	enchantments = enchants
	#Math (Bigger Decimal = More Dampening)
	enchant_damp = 0.5 + 0.5*(enchantments.get_child_count())
	
	for enchant in enchantments.get_children():
		if enchant.has_method("bullet_setup"):
			enchant.bullet_setup(self, enchant_damp)
	if bullet_damage < 5:
		bullet_damage = 5
	if bullet_speed < 5:
		bullet_speed = 5
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
			enchant.onhit(body, enchant_damp)
	queue_free()
