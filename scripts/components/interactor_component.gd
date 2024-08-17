class_name InteractorComponent
extends Node3D

@export var update_timer: Timer
@export var interact_area: Area3D

var current_interactable: InteractableComponent = null
var camera: Camera3D

func _ready():
	camera = get_viewport().get_camera_3d()

func interact() -> void:
	if current_interactable != null:
		current_interactable.activate(self)
	else:
		print("No valid interactable available")

func _on_area_3d_area_entered(area):
	if area.owner is InteractableComponent:
		_on_update_timer_timeout()


func _on_area_3d_area_exited(_area):
	if interact_area.has_overlapping_areas():
		return
	
	update_timer.stop()
	if current_interactable:
		current_interactable.hide_hint_text()
		current_interactable = null


func get_camera_target() -> InteractableComponent:
	if not interact_area.has_overlapping_areas():
		return null
	
	var closest_target: float
	var _current_targets: Dictionary
	
	for area in interact_area.get_overlapping_areas():
		if area.owner is InteractableComponent:
			var screen_pos: Vector2 = camera.unproject_position(area.global_position)
			var center_distance: float = screen_pos.distance_to(get_viewport().size/2)
			_current_targets[area.owner] = center_distance
	
	closest_target = _current_targets.values().min()
	return _current_targets.find_key(closest_target)


func _on_update_timer_timeout():
	if current_interactable:
		current_interactable.hide_hint_text()
	
	current_interactable = get_camera_target()
	
	if current_interactable != null:
		current_interactable.show_hint_text()
		update_timer.start()
