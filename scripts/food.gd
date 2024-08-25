class_name FoodBase
extends RigidBody3D

@export var interactable_component: InteractableComponent

var is_picked_up: bool = false
var grabber: GrabberComponent

func _on_interactable_component_activated(instigator: InteractorComponent):
	if is_picked_up:
		drop_food(instigator)
	else:
		pick_up_food(instigator)

func pick_up_food(instigator: InteractorComponent) -> void:
	if is_picked_up:
		return
		
	if not instigator.owner.has_node("Grabber"):
		printerr(instigator.owner.name + " does not have GrabberComponent")
		return
	
	is_picked_up = true
	grabber = instigator.owner.get_node("Grabber")
	interactable_component.hide()
	self.freeze = true
	grabber.grab_object(self)
	

func drop_food(instigator: InteractorComponent) -> void:
	if instigator.current_interactable != self.interactable_component:
		return
		
	is_picked_up = false
	print(instigator.owner.name + " is dropping food")
	interactable_component.show()
	grabber.drop_object()
	self.freeze = false
