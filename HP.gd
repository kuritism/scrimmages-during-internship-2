extends Node3D

@export var HP : int = 1
@export var SHIELD : int = 50 
@export var cooldown : float = 1.0 

func take_damage(dmg):
	if SHIELD > 0:
		SHIELD -= dmg
	else:
		HP -= dmg

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	cooldown -= 0.005
	if cooldown <= 0:
		if HP < 95:
			HP += 5
		elif HP < 100:
			HP = 100
		cooldown = 1.0

	print(HP)

