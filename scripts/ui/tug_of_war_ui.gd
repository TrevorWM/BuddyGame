class_name TugOfWarUI
extends Control

@export var buddy_button: PackedScene

func init() -> void:
	for buddy: BuddyResource in Globals.current_buddies:
		var button_instance: BuddyButton = buddy_button.instantiate()
		button_instance.init(buddy)
		%BuddyGrid.add_child(button_instance)
