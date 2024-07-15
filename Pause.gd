extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_just_pressed("ui_cancel"):
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_parent().can_move = false
		print('pawsed')
		
		


func _on_options_button_pressed():
	print('options') # Replace with function body.

func _on_resume_button_pressed():

	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#get_tree().paused = false
	get_parent().can_move = true
	print('unpawsed')


func _on_quit_button_pressed():
	get_tree().quit()
