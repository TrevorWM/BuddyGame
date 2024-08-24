class_name AIIdle
extends "res://scripts/utility_ai/utility_consideration.gd"

func activate_behaviour(buddy: Buddy) -> void:
	buddy.set_movement_target(buddy.global_position)
	buddy.state_text.text = "IDLE"
