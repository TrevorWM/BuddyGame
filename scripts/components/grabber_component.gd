class_name GrabberComponent
extends Node3D

@export var hold_position: Node3D
@export var drop_raycast: RayCast3D

var is_grabbing: bool = false
var current_object: Node3D

signal grabbed
signal dropped

func _physics_process(_delta):
	if is_grabbing and current_object != null:
		current_object.transform.origin = hold_position.global_position

func grab_object(object: Node3D) -> void:
	current_object = object
	is_grabbing = true
	grabbed.emit()

func drop_object() -> void:
	is_grabbing = false
	current_object = null
	dropped.emit()
	
