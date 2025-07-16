extends PathFollow3D
@export var rock_scene:PackedScene
var rays = []
var can_spawn:bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rays.append($DirectionNode/RayCast3D)
	rays.append($DirectionNode/RayCast3D2)
	rays.append($DirectionNode/RayCast3D3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if can_spawn:
		#spawn_rock()
		##$RockTimer.start()
	##else:
		##progress_ratio = randf()
		##print("ray hit")
		##print(str(progress_ratio))
func spawn_rock():
	var rock_instance = rock_scene.instantiate()
	rock_instance.position = position
	get_parent().add_child(rock_instance)
	rock_instance.rotation.y = $DirectionNode.rotation.y
	progress_ratio = randf()
	can_spawn = false

func _on_rock_timer_timeout() -> void:
	
	can_spawn = not check_path()
	if can_spawn:
		spawn_rock()
		$RockTimer.wait_time = 1.0
	else:
		progress_ratio = randf()
		$RockTimer.wait_time = 0.05
		#else:
			#spawn_rock()
	#can_spawn = not detected
	#print("timer timeout")
	#print(can_spawn)
func check_path() -> bool:
	var detected := false
	for r in rays:
		var col = r.get_collider()
		if col is rock or col is Area3D:
			detected = true
			#print("ray hit")
			break
		#elif col is Area3D:
			#progress_ratio = randf()
			#$RockTimer.wait_time = 0.05
	return detected

func _on_start_timer_timeout() -> void:
	$RockTimer.start()
