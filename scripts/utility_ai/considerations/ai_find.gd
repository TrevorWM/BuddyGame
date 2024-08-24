class_name AIFind
extends UtilityConsideration

@export var max_range: float = 10.0

var nearest_target: Node3D
var nearest_distance: float = 0
var target_reached = false

#TODO: Find a way to nullify this behaviour if there are no targets

func activate_behaviour(buddy: Buddy) -> void:
	is_complete = false
	target_reached = false
	buddy.state_text.text = "FINDING FOOD"
	
	nearest_distance = max_range
	
	for target in target_list:
		var current_distance = target.global_position.distance_to(buddy.global_position)
		
		if current_distance < nearest_distance:
			nearest_target = target
			nearest_distance = current_distance

	if nearest_target != null:
		buddy.set_movement_target(nearest_target.global_position)
		if buddy.navigation_agent.distance_to_target() < 2:
			target_reached = true
			is_complete = true
	else:
		print(owner.name + " did not find any valid targets in " + target_group + " group within range")
		is_complete = true
		
	
