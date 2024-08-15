class_name InteractorComponent
extends Node3D

var current_interactable: InteractableComponent = null

func interact() -> void:
	if current_interactable != null:
		print("Interacting!")
		current_interactable.activate(self)
	else:
		print("No valid interactable available")

func _on_area_3d_area_entered(area):
	if area.owner is InteractableComponent:
		current_interactable = area.owner



func _on_area_3d_area_exited(area):
	if area.owner == current_interactable:
		current_interactable = null
