class_name GrabberComponent
extends Node3D

@export var hold_position: Node3D
@export var drop_raycast: RayCast3D

var is_grabbing: bool = false
var current_object: Node3D
var current_interactable: InteractableComponent

func _physics_process(_delta):
	if is_grabbing and current_interactable != null:
		current_object.transform.origin = hold_position.global_position


func grab_object(object: Node3D) -> void:
	current_object = object
	current_interactable = object.get_node("InteractableComponent")
	is_grabbing = true


func drop_object() -> void:
	is_grabbing = false
	current_object = null
	current_interactable = null
