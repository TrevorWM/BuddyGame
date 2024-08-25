class_name ActionIdle
extends UtilityAction

func perform_action(buddy: Buddy) -> void:
	buddy.set_movement_target(buddy.global_position)
	buddy.state_text.text = "IDLE"
	buddy.stats.hunger -= 1
