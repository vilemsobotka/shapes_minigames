extends CharacterBody3D
class_name rock
@export var speed = 400
var target_velocity:Vector3

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	target_velocity = Vector3.RIGHT * speed * delta
	target_velocity = target_velocity.rotated(Vector3.UP, rotation.y)
	velocity = target_velocity
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
