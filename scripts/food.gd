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
	if not instigator.owner.has_node("Grabber"):
		print(instigator.owner.name + " does not have GrabberComponent")
		return
	
	grabber = instigator.owner.get_node("Grabber")
	interactable_component.hide()
	self.freeze = true
	grabber.grab_object(self)
	is_picked_up = true

func drop_food(instigator: InteractorComponent) -> void:
	print(instigator.owner.name + " is dropping food")
	grabber.drop_object()
	self.freeze = false
	is_picked_up = false
	interactable_component.show()
