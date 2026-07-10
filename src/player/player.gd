extends CharacterBody3D

@export var SPEED = 1.0
@export var JUMP_VELOCITY = 3.0
@export var GRAVITY = 9.76
var min_pitch: float = deg_to_rad(-80)
var max_pitch: float = deg_to_rad(80)
var mouse_sensitivity = 0.002

# Don't change
var yaw: float = 0.0
var pitch: float = 0.0



#mouse capture
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#Movement
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

#See if mouse move and change where look
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, min_pitch, max_pitch)
		rotation = Vector3(pitch, yaw, 0)

#STop mouse capture
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
