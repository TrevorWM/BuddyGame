class_name AIWander
extends UtilityConsideration

func activate_behaviour(buddy: Buddy) -> void:
	if buddy.navigation_agent.is_navigation_finished():
		buddy.set_movement_target(buddy.get_random_nearby_position())
	
	buddy.state_text.text = "WANDER"
	buddy.stats.energy -= 1
