extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_leave_button_pressed():
	hide() 


func _on_volume_value_changed(value):
	GlobalValues.volume = value
	print(GlobalValues.volume)
