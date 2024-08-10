extends Node3D
class_name FollowCameraController

@export var camera_target: Node3D
@export var yaw_sensitivity: float = 0.2
@export var pitch_sensitivity: float = 0.2

var camera_yaw: float
var camera_pitch: float
var pitch_max: float = 30
var pitch_min: float = -50

func update_camera():
	if camera_target:
		position = lerp(position, camera_target.position, 0.25)
		rotation_degrees.y = lerp(rotation_degrees.y, camera_yaw, 0.25)
		rotation_degrees.x = lerp(rotation_degrees.x, camera_pitch, 0.25)
	else:
		print("No camera target set")

func _input(event):
	if event is InputEventMouseMotion:
		camera_yaw += -event.relative.x * yaw_sensitivity
		camera_pitch += -event.relative.y * pitch_sensitivity
		camera_pitch = clampf(camera_pitch, pitch_min, pitch_max)
