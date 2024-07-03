extends RigidBody3D

@onready var bullet_speed : float = 5
@onready var bullet_damage : int = 10
@onready var bullet_spread : float
@onready var hp_comp = preload("res://HP.tscn")

func _ready():
	print("Fish")
func setup(bdam, bspeed):
	bullet_damage = bdam
	var height = (bspeed - (bspeed % 10))/10 + 1
	$Area3D/CollisionShape3D.shape.height = height
	$Area3D/CollisionShape3D.position.z = (height - 1) * 0.125
	$Area3D/CollisionShape3D.disabled = false
	


func _on_area_3d_body_entered(body):
	if body.has_node("HP"):
		var hp = body.get_node("HP")
		hp.take_damage(bullet_damage)
	queue_free()
