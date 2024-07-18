extends Control

var level = load("res://level.tscn")
var level_instance = level.instantiate()

var character = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bingo_pressed():
	character = "bingo"
	add_sibling(level_instance)
	queue_free() 

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
