class_name BuddyInteractorComponent
extends InteractorComponent

@export var buddy: Buddy
@export var interact_area: Area3D

var target_node: Node3D
var current_interactable = null

func interact() -> void:
	if interact_area.has_overlapping_areas():
		var interactable_list = interact_area.get_overlapping_areas()
		for area in interactable_list:
			if area.owner is InteractableComponent:
				area.owner.activate(self)
				current_interactable = area.owner
				return
	
func interact_with_grabbed(grabber: GrabberComponent) -> void:
	print("Grabber interact")
	if grabber:
		grabber.current_object.interactable_component.activate(self)
		current_interactable = null
	else:
		print("GrabberComponent not found on " + owner.name)
	
	
func set_target(target: Node3D) -> void:
	target_node = target
