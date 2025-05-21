extends CharacterBody3D


const SPEED := 5
@export var direction := Vector3(0,0,1)
var turning := false

func _physics_process(delta: float) -> void:
	velocity.z = direction.z * SPEED
	velocity.x = direction.x * SPEED
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

	if is_on_wall() and not turning:
		turn_arround()
		
func turn_arround() -> void:
	turning = true
	var dir = direction
	direction = Vector3.ZERO
	var turn_rotate = create_tween()
	turn_rotate.tween_property(self, "rotation_degrees", Vector3(0,180,0), 0.4).as_relative()
	await get_tree().create_timer(0.4).timeout
	direction.z = dir.z * -1 
	direction.x = dir.x * -1 
	turning = false

func _on_player_checker_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://game_over_dialog.tscn")
