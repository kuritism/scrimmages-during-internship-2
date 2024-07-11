extends Node3D

@onready var main_menu = $CanvasLayer/MainMenu
@onready var address_entry = $CanvasLayer/MainMenu/MarginContainer/VBoxContainer/AddressEntry

const Player = preload("res://player.tscn")
const PORT = 9998
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_host_button_pressed():
	main_menu.hide()
	var enet_peer = ENetMultiplayerPeer.new()
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	
	add_player(multiplayer.get_unique_id())

func _on_join_button_pressed():
	main_menu.hide()
	print("Yes")
	var enet_peer = ENetMultiplayerPeer.new()
	enet_peer.create_client("localhost", PORT)
	if enet_peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = enet_peer
	
	
func add_player(peer_id):
	print("Ding")
	var player = Player.instantiate()
	player.name = str(peer_id)
	print("Ding")
	print(player.name)
	add_child(player)


func _on_multiplayer_spawner_spawned(node):
	print("bob")
