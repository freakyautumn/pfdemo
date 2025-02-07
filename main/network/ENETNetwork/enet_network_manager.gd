class_name ENETNetworkManager
extends Node

const DEFAULT_MAX_CLIENTS : int = 4
const DEFAULT_PORT : int = 8080
const DEFAULT_IP : String = "localhost"

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
func start_host(port : int = DEFAULT_PORT, max_clients : int = DEFAULT_MAX_CLIENTS, _is_headless : bool = headless) -> void: #TODO: Headless
	multiplayer.multiplayer_peer.close()
	# Start a server
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port, max_clients)
	multiplayer.multiplayer_peer = peer

# Called by this server when a client connects
func _on_peer_connected(peer_id : int):
	if Debug.debug: print("%s - Multiplayer Peer %s Connected!" % [self, peer_id])

# Called by this server when a client disconnects
func _on_peer_disconnected(peer_id : int):
	if Debug.debug: print("%s - Multiplayer Peer %s Disconnected!" % [self, peer_id])

# Start a client
func start_client(ip_address : String = DEFAULT_IP, port : int = DEFAULT_PORT) -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip_address, port)
	multiplayer.multiplayer_peer = peer

# Called when this client connects to the server
func _on_connected_to_server() -> void: pass

# Called when this client fails to connect to the server
func _on_connection_failed() -> void: pass

# Called by this client when the server is diconnected
func _on_server_disconnected(): multiplayer.multiplayer_peer.close()
