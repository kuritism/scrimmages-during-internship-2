extends Control

var selection = load("res://Selection.tscn")
var settings = load("res://Settings.tscn")
var selection_instance = selection.instantiate()
var settings_instance = settings.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(settings_instance)
	settings_instance.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	add_sibling(selection_instance)
	queue_free() 


func _on_settings_pressed():
	settings_instance.show()
	

func _on_quit_pressed():
	get_tree().quit()
