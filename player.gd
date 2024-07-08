extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var gun := $"TwistPivot/PitchPivot/Gun Component"

func _ready() -> void:
	if not is_multiplayer_authority(): return
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$TwistPivot/PitchPivot/Camera3D.current = true
	
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
		deg_to_rad(-90), 
		deg_to_rad(90)
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

@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer

const Player = preload("res://player.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

func _unhandled_input(event: InputEvent) -> void:
	if not is_multiplayer_authority(): return
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity


func _on_host_button_pressed():
	main_menu.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)

	add_player(multiplayer.get_unique_id())

func _on_join_button_2_pressed():
	main_menu.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer

func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)


