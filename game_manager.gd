extends Node
var games = {}

func _ready() -> void:
	var path = "res://games/"
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file = dir.get_next()
		while file != "":
			if file.get_extension() == "tscn":
				var full_path = path.path_join(file)
				games[file] = full_path
			file = dir.get_next()
	#print(games)
func load_scene(path:String):
	get_tree().paused = false
	PlayerManager.players.clear()
	get_tree().change_scene_to_file(path)
