extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var gun := $"TwistPivot/PitchPivot/Gun Component"

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_backward")
	
	if $"Floor Detection".is_colliding() and Input.is_action_just_pressed("jump"):
		input.y = 20

	apply_central_force(twist_pivot.basis * input * 1500.0 * delta)
	
	var aligned_force = twist_pivot.basis * input
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
		
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
		deg_to_rad(-80), 
		deg_to_rad(80)
	)
	twist_input = 0.0
	pitch_input = 0.0
	if Input.is_action_pressed("fire"):
		gun.attempt_fire()
	if Input.is_action_pressed("reload"):
		gun.attempt_reload()

	if $"HP".HP <= 0:
		for child in self.get_children():
			child.queue_free()

func on_enchant_pickup(new_enchant):
	print("PickUP!")
	print(new_enchant)
	gun.on_enchant_pickup(new_enchant)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
