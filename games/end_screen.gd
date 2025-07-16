extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_left"):
		GameManager.load_scene("res://main.tscn")
	elif event.is_action_released("ui_right"):
		GameManager.load_scene("res://games/game1.tscn")
