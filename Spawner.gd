extends Area3D

@export var pickup: Resource
var rng = RandomNumberGenerator.new()
var current_pickup = null
# Called when the node enters the scene tree for the first time.

func _ready():
	$Timer.start(rng.randi_range(5, 10))

@rpc("any_peer", "call_local")
func spawn_object():
	$Timer.stop()
	if !current_pickup:
		current_pickup = pickup.instantiate()
		add_child(current_pickup)
		current_pickup.position = Vector3(0, 1, 0)
	
func _on_timer_timeout():
	self.spawn_object.rpc()
	
func _on_area_exited(area):
	print("Body")
	print(area)
	print("curr Pick")
	print(current_pickup)
	if area == current_pickup:
		print("New Pickup")
		current_pickup = null
		$Timer.start(rng.randi_range(20, 40))
	
