class_name ActionWander
extends UtilityAction

@export var wander_radius: float = 5.0

func perform_action(buddy: Buddy) -> void:
	if buddy.navigation_agent.is_navigation_finished():
		buddy.set_movement_target(get_random_nearby_position(buddy, wander_radius))
	
	buddy.state_text.text = "WANDER"
	buddy.data.energy -= 1
	buddy.data.hunger -= 5

func get_random_nearby_position(buddy: Buddy, radius: float) -> Vector3:
	return Vector3(
				randf_range(buddy.global_position.x - radius, buddy.global_position.x + radius), 
				0, 
				randf_range(buddy.global_position.z - radius, buddy.global_position.z + radius))
