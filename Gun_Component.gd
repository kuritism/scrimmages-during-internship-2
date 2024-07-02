extends Node3D
var can_fire = true
@onready var instancedBull = load("res://Bullet.tscn")
@onready var root = get_tree().get_root()  
@export var mag_size : int = 20
@export var num_reloads : int = 3
@export var chamber_time : float = 0.3
@export var reload_time : float = 1
@export var bullet_speed : float = 20
@export var bullet_damage : int = 10
@export var bullet_spread : float
@export var shell_amount : int = 1
@export var num_bullets = mag_size
@export var additional_bullets = mag_size * num_reloads
# Called when the node enters the scene tree for the first time.
func attempt_fire():
	if !can_fire:
		return
	print("Fire!")
	for i in range(shell_amount):
		print("Summon!")
		var bullet = instancedBull.instantiate()
		var angle = rotation
		print(angle)
		add_child(bullet)
		bullet.setup(bullet_damage)
		bullet.position.x=position.x
		bullet.position.y=position.y - 0.5
		bullet.position.z=position.z + 1
		bullet.apply_central_force(global_transform.basis.z * bullet_speed * 500)
		bullet.reparent(root)
	num_bullets -= 1
	can_fire = false
	print(num_bullets)
	if num_bullets:
		print("Chamber_Time")
		$Chamber_Time.start(chamber_time)
	elif additional_bullets:
		print("Reload_Time")
		$Reload_Time.start(reload_time)

func attempt_reload():
	if additional_bullets and num_bullets < mag_size and !$Reload_Time.time_left:
		$Chamber_Time.stop()
		$Reload_Time.start(reload_time)
		print("Reload Attempted")
		can_fire = false


func _on_reload_time_timeout():
	print("Reload Finish!")
	if additional_bullets > mag_size - num_bullets:
		additional_bullets -= mag_size - num_bullets
		num_bullets = mag_size
	else:
		num_bullets += additional_bullets
		additional_bullets = 0
	can_fire = true


func _on_chamber_time_timeout():
	print("Chamber Finish!")
	can_fire = true
