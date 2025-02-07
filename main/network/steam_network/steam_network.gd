class_name SteamNetwork
extends Node


const STEAM_PORT : int = 0

@export_group("Network Settings")
@export var headless : bool = false

func _ready() -> void:
	connect_signals()
	if headless: start_host()

# Connects the ENETMultiplayerPeer callback signals
func connect_signals() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

# Function to start a host
func start_host(port : int = STEAM_PORT) -> void: #TODO: Headless
	multiplayer.multiplayer_peer.close()
	# Start a server
	var peer : MultiplayerPeer = SteamMultiplayerPeer.new()
	peer.create_host(port)
	multiplayer.multiplayer_peer = peer

# Called by this server when a client connects
func _on_peer_connected(peer_id : int):
	if Debug.debug: print("%s - Multiplayer Peer %s Connected!" % [self, peer_id])

# Called by this server when a client disconnects
func _on_peer_disconnected(peer_id : int):
	if Debug.debug: print("%s - Multiplayer Peer %s Disconnected!" % [self, peer_id])

# Start a client
func start_client(port : int = STEAM_PORT) -> void:
	var peer = SteamMultiplayerPeer.new()
	peer.create_client(port)
	multiplayer.multiplayer_peer = peer

# Called when this client connects to the server
func _on_connected_to_server() -> void: pass

# Called when this client fails to connect to the server
func _on_connection_failed() -> void: pass

# Called by this client when the server is diconnected
func _on_server_disconnected(): multiplayer.multiplayer_peer.close()

func _process(delta: float) -> void:
	Steam.run_callbacks()
