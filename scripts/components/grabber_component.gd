class_name GrabberComponent
extends Node3D

@export var hold_position: Node3D
@export var drop_raycast: RayCast3D

var is_grabbing: bool = false
var current_object: Node3D

func grab_object(object: Node3D) -> void:
	object.get_parent().remove_child(object)
	hold_position.add_child(object)
	print(object.name)
	object.position = Vector3.ZERO
	current_object = object

func drop_object() -> void:
	drop_raycast.force_raycast_update()
	
	if drop_raycast.is_colliding():
		var ground:Node3D = drop_raycast.get_collider().owner
		
		hold_position.remove_child(current_object)
		ground.add_child(current_object)
		#current_object.global_position = hold_position.global_position
		current_object = null
		
