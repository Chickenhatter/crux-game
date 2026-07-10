extends CharacterBody3D

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 5.0
@export var GRAVITY = 10.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= 10 * delta
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction != Vector3.ZERO:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
		velocity.z = move_toward(velocity.z, 0.0, SPEED)

	move_and_slide()
	#var mouse_pos = get_viewport().get_mouse_position()
	#
	#var camera = $Camera3D
#
	#var ray_origin = camera.project_ray_origin(mouse_pos)
	#var ray_direction = camera.project_ray_normal(mouse_pos)
	#var plane = Plane(Vector3.UP, 0)
	#var intersection = plane.intersects_ray(ray_origin, ray_direction)
	#if intersection:
		#print("Mouse position in 3D:", intersection)
	var vp_size = get_viewport().get_visible_rect().size
	var mouse_pos = get_viewport().get_mouse_position()
	var left_size = (vp_size.x / 3)
	var right_size = (vp_size.x * 2/3)
	var top_size = (vp_size.y / 3)
	var bottom_size = (vp_size.y * 2 / 3)
	if mouse_pos.y < top_size:
		$Camera3D.rotate_x(deg_to_rad(1))
	if mouse_pos.y > bottom_size:
		$Camera3D.rotate_x(deg_to_rad(-1))
	
	if mouse_pos.x < right_size:
		rotate_y(deg_to_rad(1))
	if mouse_pos.x > left_size:
		rotate_y(deg_to_rad(-1))
