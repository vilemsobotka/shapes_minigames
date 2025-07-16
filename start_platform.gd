extends StaticBody3D


func _on_dissapear_timer_timeout() -> void:
	queue_free()
