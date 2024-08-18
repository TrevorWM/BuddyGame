class_name FoodBase
extends Node3D

@export var interactable_component: InteractableComponent
@export var rigidbody: RigidBody3D
@export var hold_position: Node3D

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
	
	print("Food picked up by: " + instigator.owner.name)
	interactable_component.hide()
	rigidbody.freeze = true
	grabber.grab_object(self)
	is_picked_up = true

func drop_food(instigator: InteractorComponent) -> void:
	print(instigator.owner.name + " is dropping food")
	grabber.drop_object()
	rigidbody.freeze = false
	is_picked_up = false
	interactable_component.show()
