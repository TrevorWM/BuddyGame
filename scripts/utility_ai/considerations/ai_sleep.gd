class_name AISleep
extends UtilityConsideration


func activate_behaviour(buddy: Buddy) -> void:
	if stats.energy == stats.max_energy:
		is_complete = true
		return
	
	is_complete = false
	buddy.set_movement_target(buddy.global_position)
	buddy.state_text.text = "SLEEP"
	stats.energy += 1
