class_name BuddyButton
extends Control

var buddy_resource: BuddyResource

func init(resource: BuddyResource) -> void:
	buddy_resource = resource
	%Label.text = buddy_resource.buddy_name


func _on_texture_button_pressed() -> void:
	SignalBus.buddy_selected.emit(buddy_resource)
