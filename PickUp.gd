extends Area3D

@export var enchants: String
func _ready():
	var dir := DirAccess.open(enchants)
	var file_names := dir.get_files()
	var random_file = enchants + file_names[randi() % file_names.size()]
	var enchant = load(random_file).instantiate()
	$Enchant.add_child(enchant)
	

func _on_body_entered(body):
	if body.has_method("on_enchant_pickup"):
		body.on_enchant_pickup($Enchant.get_child(0))
		queue_free()
