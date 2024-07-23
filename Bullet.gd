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

@onready var enchant_damp = 1


func setup(gun_basis, enchants, gun_stats):
	stats = gun_stats.duplicate()
	if enchants:
		for enchant in enchants:
			$Enchantments.add_child(enchant.duplicate())
	
	enchant_damp = 0.5 + 0.5*($Enchantments.get_child_count())
	
	if stats["Bullet Damage"] < 1:
			stats["Bullet Damage"] = 1
	if stats["Bullet Speed"] < 1:
		stats["Bullet Speed"] = 1
	apply_central_force(gun_basis * stats["Bullet Speed"] * 150)
	for enchant in $Enchantments.get_children():
			if enchant.has_method("bullet_setup"):
				enchant.bullet_setup(self, enchant_damp)
				
	
	var height = (stats["Bullet Speed"] - (int(round(stats["Bullet Speed"])) % 10))/10 + 1
	$"Area3D/CollisionShape3D".shape.height = height
	$"Area3D/CollisionShape3D".position.z = (height - 1) * 0.125
	$"Area3D/CollisionShape3D".disabled = false
	$"Timer".start(stats["Bullet Life"])
	reparent(get_tree().get_root())
	


func _on_area_3d_body_entered(body):
	print(body)
	if body.has_node("GUI"):
		
		var hp = body.get_node("./GUI/HP")
		print("Da damage: " + str(stats["Bullet Damage"]))
		hp.take_damage(stats["Bullet Damage"])
	if $Enchantments.get_children():
		for enchant in $Enchantments.get_children():
			if enchant.has_method("onhit"):
				enchant.onhit(body, enchant_damp)
	disable_bullet()
	
func disable_bullet():
	$Area3D.disable_mode = true
	$"Bullet Mesh".hide()
	$GPUParticles3D.emitting = false
	$Timer.start($GPUParticles3D.lifetime)
func _physics_process(_delta):
	if get_linear_velocity():
		look_at(position - get_linear_velocity(), Vector3.UP)
		
func _on_timer_timeout():
	if !$Area3D.disable_mode:
		disable_bullet()
	else:
		print("Deleted!")
		queue_free()
