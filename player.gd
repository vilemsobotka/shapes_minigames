extends CharacterBody3D
class_name Player

@export var speed = 700.0
@export var fall_acceleration = 50.0
@export var jump_speed := 700.0
@export var jump_acceleration = 100.0


var model_id := 0
var move := true
var playerID
var left_input
var inputs = {"top": "", "down" : "", "left" : "", "right" : "", "jump" : ""}
var target_velocity := Vector3.ZERO
var can_extend_jump := false
var player_color:Vector3

func _ready() -> void:
	inputs["top"] = "player" + str(playerID) + "_forward" 
	inputs["down"] = "player" + str(playerID) + "_back" 
	inputs["left"] = "player" + str(playerID) + "_left" 
	inputs["right"] = "player" + str(playerID) + "_right" 
	inputs["jump"] = "player" + str(playerID) + "_jump"
	
	var model_instance = load(PlayerManager.models[model_id]).instantiate()
	var mat = ShaderMaterial.new()
	mat.shader = load("res://player_color_shader.gdshader")
	mat.set_shader_parameter("playerColor", player_color)
	model_instance.get_child(0).get_child(0).mesh.surface_set_material(0, mat)
	$Pivot.add_child(model_instance)
func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	if Input.is_action_pressed(inputs["top"]):
		direction.z += 1
	if Input.is_action_pressed(inputs["down"]):
		direction.z += -1
	if Input.is_action_pressed(inputs["right"]):
		direction.x += -1
	if Input.is_action_pressed(inputs["left"]):
		direction.x += 1
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction).rotated(Vector3.UP, PI)
	target_velocity = Vector3(direction.x * speed, target_velocity.y, direction.z * speed)
	
	if Input.is_action_just_pressed(inputs["jump"]) and is_on_floor():
		#can_extend_jump = true;
		$JumpExtendStartTimer.start()
		#$JumpExtendTimer.start()
		target_velocity.y = jump_speed
	if not is_on_floor():
		if Input.is_action_pressed(inputs["jump"]) and can_extend_jump:
			target_velocity.y += jump_acceleration
		else:
			target_velocity.y -= fall_acceleration
	if move:
		velocity = target_velocity * delta
		move_and_slide()


func _on_jump_extend_timer_timeout() -> void:
	can_extend_jump = false


func _on_jump_extend_start_timer_timeout() -> void:
	$JumpExtendTimer.start()
	can_extend_jump = true


func _on_lava_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("death"):
		die()
func die():
	var i = 0
	for p in PlayerManager.players:
		if p.playerID == playerID:
			PlayerManager.players.erase(p)
		i+=1
	queue_free()
