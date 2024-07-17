extends Node3D

@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEntry

const Player = preload("res://player.tscn")
const PORT = 9999
var enet_peer = ENetMultiplayerPeer.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("next_song"):
		play_song()

func play_song():
	var res = null
	var random_file = "nullimport"
	var dir_name := "res://Assets/Audio/Music"
	var dir := DirAccess.open(dir_name)
	var file_names := dir.get_files()
	while "import" in random_file:
		random_file = file_names[randi() % file_names.size()] 
		res = load("res://Assets/Audio/Music/" + random_file)
	print(res)
	
	$AudioStreamPlayer.stream = res
	if !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()
	else: return

func _on_host_button_pressed():
	main_menu.hide()
	
	enet_peer.create_server(PORT,32)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	add_player(multiplayer.get_unique_id())
	
	play_song()
	#upnp_setup()

func _on_join_button_pressed():
	main_menu.hide()

	
	enet_peer.create_client(address_entry.text, PORT)
	multiplayer.multiplayer_peer = enet_peer
	play_song()

	
func add_player(peer_id):
	print("Ding")
	var player = Player.instantiate()
	player.name = str(peer_id)
	print("Ding")
	print(player.name)
	add_child(player)

func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()


func _on_multiplayer_spawner_spawned(node):
	print("bob")
	
#func upnp_setup():
	#var upnp = UPNP.new()
	#
	#var discover_result = upnp.discover()
	#assert(discover_result == UPNP.UPNP_RESULT_SUCCESS, \
		#"UPNP Discover Failed! Error %s" % discover_result)
#
	#assert(upnp.get_gateway() and upnp.get_gateway().is_valid_gateway(), \
		#"UPNP Invalid Gateway!")
#
	#var map_result = upnp.add_port_mapping(PORT)
	#assert(map_result == UPNP.UPNP_RESULT_SUCCESS, \
		#"UPNP Port Mapping Failed! Error %s" % map_result)
	#
	#print("Success! Join Address: %s" % upnp.query_external_address())


func _on_audio_stream_player_finished():
	play_song()
