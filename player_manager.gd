extends Node
var players = []
var player_count = 0
var player_models = {}
var player_colors = {}
@export var player_scene:PackedScene
@export var start_platform_scene:PackedScene
@export var models:PackedStringArray
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn_player(player_ID, spawner, player_color:Vector3, model_id = 0, spawn_area = 0, platform = true):
	var player = player_scene.instantiate()
	player.playerID = player_ID
	player.model_id = model_id
	player.player_color = player_color
	players.append(player)
	spawner.add_child(player)
	player.position.x += randf_range(-spawn_area, spawn_area)
	player.position.z += randf_range(-spawn_area, spawn_area)
	if platform:
		var start_platform_instance = start_platform_scene.instantiate()
		start_platform_instance.position = player.position
		spawner.add_child(start_platform_instance)
	print("spawned player " + str(player_ID) + "color:" + str(player_color))
func spawn_all_players(spawner, spawn_area = 0, platform = true):
	var i = 0
	while i < PlayerManager.player_count:
		PlayerManager.spawn_player(i + 1, spawner,player_colors[i+1], player_models[i+1], spawn_area, platform)
		i = i+1
