class_name Player
extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var follow_camera_controller: FollowCameraController

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta):
	handle_mouse_mode()
	handle_interact()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	handle_jump()
	handle_movement()
	move_and_slide()
	
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		follow_camera_controller.update_camera()

func handle_movement():
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = input_dir.x * SPEED
		velocity.z = input_dir.y * SPEED
		
		# rotates the velocity to match the camera direction and character to face
		# the direction moving
		velocity = velocity.rotated(Vector3.UP, follow_camera_controller.rotation.y)
		look_at(global_position + Vector3(velocity.x, 0, velocity.z))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
func handle_mouse_mode():
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE and Input.is_action_just_pressed("click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func handle_interact() -> void:
	if Input.is_action_just_pressed("interact"):
		$InteractorComponent.interact()
