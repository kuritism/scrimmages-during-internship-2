extends Node3D
var can_fire = true
var current_select = null
@onready var instancedBull = load("res://Bullet.tscn")
@export var base_stats : Dictionary = {
	"Mag Size": 20,
	"Reload Number": 3,
	"Chamber Time": 3,
	"Reload Time": 10,
	"Bullet Damage": 10,
	"Bullet Speed": 20,
	"Bullet Life": 1,
	"Bullet Spread": 1,
	"Shell Amount": 1
}

var stats = base_stats.duplicate()
var num_bullets = stats["Mag Size"]
var additional_bullets = stats["Mag Size"] * stats["Reload Number"]
# Called when the node enters the scene tree for the first time.
func _ready():
	on_enchant_pickup(null)
func attempt_fire():
	if !can_fire:
		return
	print("Fire!")
	for i in range(stats["Shell Amount"]):
		print("Summon!")
		var bullet = instancedBull.instantiate()
		var angle = rotation
		print(angle)
		add_child(bullet)
		bullet.position.x=position.x
		bullet.position.y=position.y - 0.5
		bullet.position.z=position.z + 1.5
		bullet.setup(global_transform.basis.z, $Enchantments, stats)
	num_bullets -= 1
	can_fire = false
	print(num_bullets)
	if num_bullets:
		print("Chamber_Time")
		var time = float(stats["Chamber Time"]) / 10
		$Chamber_Time.start(time)
	elif additional_bullets:
		print("Reload_Time")
		var time = float(stats["Reload Time"]) / 10
		$Reload_Time.start(time)

func attempt_reload():
	if additional_bullets and num_bullets < stats["Mag Size"] and !$Reload_Time.time_left:
		$Chamber_Time.stop()
		$Reload_Time.start(stats["Reload Time"] / 10)
		print("Reload Attempted")
		can_fire = false

func on_enchant_pickup(new_enchant):
	if new_enchant:
		if $Enchantments.has_node(NodePath(new_enchant.name)):
			print("No enchant applied")
			num_bullets = stats["Mag Size"]
			additional_bullets = stats["Mag Size"] * stats["Reload Number"]
			return
		new_enchant = new_enchant.duplicate()
		if current_select or $Enchantments.get_child_count() > 2:
			print("Replace")
			current_select = new_enchant
		else:
			print("Add Enchant")
			$Enchantments.add_child(new_enchant)
	stats = base_stats.duplicate()
	var enchant_damp = 0.5 + 0.5*($Enchantments.get_child_count())
	for enchant in $Enchantments.get_children():
		if enchant.has_method("gun_setup"):
			var new_stat = enchant.gun_setup(self)
			print(new_stat)
			for i in new_stat:
				stats[i] +=  new_stat[i] / enchant_damp
			print(stats)
	for i in stats:
		if stats[i] < 1:
			stats[i] = 1
	num_bullets = stats["Mag Size"]
	additional_bullets = stats["Mag Size"] * stats["Reload Number"]
func _on_reload_time_timeout():
	print("Reload Finish!")
	if additional_bullets > stats["Mag Size"] - num_bullets:
		additional_bullets -= stats["Mag Size"] - num_bullets
		num_bullets = stats["Mag Size"]
	else:
		num_bullets += additional_bullets
		additional_bullets = 0
	can_fire = true

func _on_chamber_time_timeout():
	print("Chamber Finish!")
	can_fire = true
