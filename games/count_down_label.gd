extends Label
@export var t := 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(t)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_count_down_timer_timeout() -> void:
	t-=1
	if t < 0:
		queue_free()
	else:
		text = str(t)
