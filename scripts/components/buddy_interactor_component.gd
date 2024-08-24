class_name BuddyInteractorComponent
extends InteractorComponent

@export var buddy: Buddy
@export var raycast: RayCast3D

var target_node: Node3D
var current_interactable = null

func interact() -> void:
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		var interactable: InteractableComponent = raycast.get_collider().owner
		interactable.activate(self)
		current_interactable = interactable
	
func interact_with_grabbed(grabber: GrabberComponent) -> void:
	if grabber:
		grabber.current_object.interactable_component.activate(self)
		current_interactable = null
	else:
		print("GrabberComponent not found on " + owner.name)
	
	
func set_target(target: Node3D) -> void:
	target_node = target
