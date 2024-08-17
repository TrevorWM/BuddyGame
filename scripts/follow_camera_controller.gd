extends Node3D
class_name FollowCameraController

@export var camera_target: Node3D

@export_category("Sensitivity")
@export var yaw_sensitivity: float = 0.2
@export var pitch_sensitivity: float = 0.2

@export_category("Constraints")
@export var pitch_max: float = 30
@export var pitch_min: float = -50

var camera_yaw: float
var camera_pitch: float
var last_position: Vector3
var position_offset: Vector3 = position

func _ready():
	last_position = camera_target.global_position

func update_camera():
	if camera_target:
		position = lerp(last_position, camera_target.global_position + position_offset, 0.25)
		last_position = position
		rotation_degrees.y = lerp(rotation_degrees.y, camera_yaw, 0.25)
		rotation_degrees.x = lerp(rotation_degrees.x, camera_pitch, 0.25)
	else:
		print("No camera target set")

func _input(event):
	if not camera_target:
		return
	
	if event is InputEventMouseMotion:
		camera_yaw += -event.relative.x * yaw_sensitivity
		camera_pitch += -event.relative.y * pitch_sensitivity
		camera_pitch = clampf(camera_pitch, pitch_min, pitch_max)
