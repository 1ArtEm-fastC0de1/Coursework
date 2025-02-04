extends CharacterBody3D

const SPEED = 4
const JUMP_VELOCITY = 8
const CAMERA_SPEED = 5.0
const MOUSE_SENSITIVITY = 0.005  # Чувствительность мыши для поворота камеры

var camera_rotation_x = 0.0  # Угол поворота камеры по оси X (вверх/вниз)
var camera_rotation_y = 0.0  # Угол поворота камеры по оси Y (влево/вправ)

var xform : Transform3D

func _ready():
	# Отключаем захват курсора, чтобы он не выходил за пределы экрана
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = ($CameraController.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if input_dir != Vector2.ZERO:
		$Armature.rotation_degrees.y = $CameraController.rotation_degrees.y - rad_to_deg(input_dir.angle()) + 90
		$AnimationPlayer.play("move")
	else:
		$AnimationPlayer.play("idle")
		
	# align character with floor
	if is_on_floor():
		align_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform,0.3)
	elif not is_on_floor():
		align_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform,0.3)
		
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# smooth zoom camera
	$CameraController.position = lerp($CameraController.position, position, CAMERA_SPEED * delta)

	# Update the camera's rotation based on the mouse movement
	_handle_mouse_look(delta)

func _handle_mouse_look(delta: float) -> void:
	var mouse_motion = Input.get_last_mouse_velocity()# Получаем движение мыши

	if mouse_motion is Vector2:  # Проверяем, что mouse_motion действительно является вектором
		var mouse_delta_x = mouse_motion.x * MOUSE_SENSITIVITY
		var mouse_delta_y = mouse_motion.y * MOUSE_SENSITIVITY

		# Обновляем углы поворота камеры
		camera_rotation_y -= mouse_delta_x  # Поворот по оси Y (влево/вправ)
		camera_rotation_x = clamp(camera_rotation_x - mouse_delta_y, -25, 25)  # Поворот по оси X (вверх/вниз), ограничиваем между -90 и 90 градусами

		# Применяем повороты камеры
		$CameraController.rotation_degrees = Vector3(camera_rotation_x, camera_rotation_y, 0)

func align_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()
	


func _on_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	get_tree().change_scene_to_file("res://level_1.tscn");
