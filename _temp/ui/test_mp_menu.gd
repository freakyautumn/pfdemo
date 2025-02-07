extends Control
#TODO: Do not use this script. This is temp, meant to be refactored
@onready var host: Button = $Host
@onready var join: Button = $Join
@onready var start: Button = $Start
@export var player_scene: PackedScene
@export var world : Node2D

func _ready() -> void:
	var network_manager = NetworkManager.new()
	add_child(network_manager)
	host.pressed.connect(network_manager.start_host)
	join.pressed.connect(network_manager.start_client)
	start.pressed.connect(_on_start_pressed)


func _on_start_pressed() -> void:
	rpc("start_it")

@rpc("authority", "call_local")
func start_it():
	if multiplayer.is_server():
		var peers : Array = multiplayer.get_peers()
		peers.append(1)
		var i = 30
		for client in peers:
			print("Client : %s" % client)
			var player : Player = player_scene.instantiate()
			player.name = str("Player%s" %client)
			player.peer_id = client
			player.global_position = Vector2(i, -10)
			world.player_node.add_child(player)
			i += 30
	self.hide()
