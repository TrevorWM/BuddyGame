class_name InteractorComponent
extends Node3D

@export var update_timer: Timer
@export var interact_area: Area3D

var current_interactable: InteractableComponent = null
var object_grabbed: bool = false
var camera: Camera3D
var target_group: String = ""

func _ready():
	camera = get_viewport().get_camera_3d()

func interact() -> void:
	if owner is Buddy:
		for area: Area3D in interact_area.get_overlapping_areas():
			if area.owner is InteractableComponent and area.owner.owner.is_in_group(target_group):
				current_interactable = area.owner
		
	if current_interactable != null:
		current_interactable.activate(self)
	else:
		print("No valid interactable available")
		
func interact_with_grabbed(grabber: GrabberComponent) -> void:
	if grabber:
		grabber.current_object.interactable_component.activate(self)
		current_interactable = null
	else:
		print("GrabberComponent not found on " + owner.name)

func _on_area_3d_area_entered(area):
	if area.owner is InteractableComponent and owner is Player:
		_on_update_timer_timeout()


func _on_area_3d_area_exited(_area):
	if owner is Buddy:
		return
		
	if interact_area.has_overlapping_areas():
		return
	
	if update_timer.is_stopped():
		update_timer.stop()

	if current_interactable:
		current_interactable.hide_hint_text()
		current_interactable = null


func get_camera_target() -> InteractableComponent:
	if not interact_area.has_overlapping_areas():
		return null
	
	var closest_distance: float = 99999
	var closest_target: InteractableComponent
	
	for area in interact_area.get_overlapping_areas():
		if area.owner is InteractableComponent:
			var screen_pos: Vector2 = camera.unproject_position(area.global_position)
			var center_distance: float = screen_pos.distance_to(get_viewport().size/2)
			
			if center_distance < closest_distance:
				closest_distance = center_distance
				closest_target = area.owner
			
	return closest_target


func _on_update_timer_timeout():
	if object_grabbed:
		return
	
	if not owner is Player:
		return
	
	if current_interactable:
		current_interactable.hide_hint_text()
	
	current_interactable = get_camera_target()
	
	if current_interactable != null:
		current_interactable.show_hint_text(self)
		update_timer.start()

func interactable_grabbed() -> void:
	object_grabbed = true

func interactable_dropped() -> void:
	object_grabbed = false

func set_target_group(group: String) -> void:
	target_group = group
