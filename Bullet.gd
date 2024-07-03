extends RigidBody3D

@onready var bullet_speed : float = 5
@onready var bullet_damage : int = 10
@onready var bullet_spread : float

func _ready():
	print("Fish")
func setup(bdam):
	bullet_damage = bdam
