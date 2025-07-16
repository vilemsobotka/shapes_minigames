extends game

var end_screen:Control
var win_text:Label
var spawn_marker
@export var spawn_area = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	end_screen = $Control/EndScreen
	end_screen.visible = false
	win_text = $Control/EndScreen/WinAnnouncement
	title = "lava floor"
	spawn_marker = $SpawnMarker
	var i = 0
	PlayerManager.spawn_all_players(spawn_marker, spawn_area)
	print(PlayerManager.players)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if PlayerManager.players.size() == 1:
		win_text.text = "Player " + str(PlayerManager.players[0].playerID) + " wins!!"
		end_screen.visible = true
		get_tree().paused = true
	elif PlayerManager.players.size() == 0:
		win_text.text = "draw"
		end_screen.visible = true
		get_tree().paused = true
#func spawn_player(player, spawn):
	#add_child(player)
	#player.position.x = randf_range(-spawn_area, spawn_area)
	#player.position.y = randf_range(-spawn_area, spawn_area)
	#player.position.y = spawn.position.y
