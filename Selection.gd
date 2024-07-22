extends Control

var level = preload("res://level.tscn")
var level_instance = level.instantiate()

var character = ""
var can_delete = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_delete:
		add_sibling(level_instance)
		queue_free()



func _on_bingo_pressed():
	var character = "bingo"
	can_delete = true

func _on_emu_pressed():
	pass # Replace with function body.


func _on_spongebob_pressed():
	pass # Replace with function body.


func _on_autism_pressed():
	pass # Replace with function body.


func _on_petticoat_pressed():
	pass # Replace with function body.


func _on_random_pressed():
	pass # Replace with function body.
