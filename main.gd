extends Node
var spawners = []
@export var player_scene:PackedScene
var spawn_point
var game_list:ItemList
var selected_game
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawners = $Spawners.get_children()
	spawn_point = $SpawnPoint
	PlayerManager.spawn_all_players(spawn_point, 16, false)
	
	game_list = $Control/ColorRect/GameList
	var i = 0
	for g in GameManager.games:
		game_list.add_item(GameManager.games.keys()[i])
		i+=1
	game_list.grab_focus()
	game_list.select(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start") and selected_game != null:
		GameManager.load_scene(GameManager.games.values()[selected_game])
func _unhandled_input(event: InputEvent) -> void:
	#var spawner = spawners[event.device]
	if Input.is_action_just_pressed("add_player"):
		var player_exists = false
		for p in PlayerManager.players:
			if p.playerID == event.device + 1:
				player_exists = true
		if not  player_exists:
			add_player(event.device + 1, spawn_point)
func add_player(player_ID:int, spawner):
	var model_id = randi_range(0, PlayerManager.models.size() - 1)
	var color = Vector3(randf(), randf(), randf())
	PlayerManager.spawn_player(player_ID, spawner, color, model_id, 16, false)
	PlayerManager.player_models[player_ID] = model_id
	PlayerManager.player_colors[player_ID] = color
	var fw = InputEventJoypadMotion.new()
	fw.device = player_ID - 1
	fw.axis = JOY_AXIS_LEFT_Y
	fw.axis_value = -1.0
	
	var bk = InputEventJoypadMotion.new()
	bk.device = player_ID - 1
	bk.axis = JOY_AXIS_LEFT_Y
	bk.axis_value = 1.0
	
	var l = InputEventJoypadMotion.new()
	l.device = player_ID - 1
	l.axis = JOY_AXIS_LEFT_X
	l.axis_value = -1.0
	
	var r = InputEventJoypadMotion.new()
	r.device = player_ID - 1
	r.axis = JOY_AXIS_LEFT_X
	r.axis_value = 1.0
	
	var jump = InputEventJoypadButton.new()
	jump.device = player_ID - 1
	jump.button_index = 0
	
	InputMap.add_action("player" + str(player_ID) + "_forward", 0.2)
	InputMap.action_add_event("player" + str(player_ID) + "_forward", fw)
	
	InputMap.add_action("player" + str(player_ID) + "_back", 0.2)
	InputMap.action_add_event("player" + str(player_ID) + "_back", bk)
	
	InputMap.add_action("player" + str(player_ID) + "_left", 0.2)
	InputMap.action_add_event("player" + str(player_ID) + "_left", l)
	
	InputMap.add_action("player" + str(player_ID) + "_right", 0.2)
	InputMap.action_add_event("player" + str(player_ID) + "_right", r)
	
	InputMap.add_action("player" + str(player_ID) + "_jump", 0.2)
	InputMap.action_add_event("player" + str(player_ID) + "_jump", jump)
	#print("created player " + str(player.playerID))
	PlayerManager.player_count += 1

func _on_game_list_item_selected(index: int) -> void:
	selected_game = index
