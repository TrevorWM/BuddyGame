class_name ActionFind
extends UtilityAction

@export var max_range: float = 5.0
var closest_object: Node3D

func perform_action(buddy: Buddy) -> void:
	buddy.state_text.text = "FINDING FOOD"
	is_complete = false
	var targets = get_tree().get_nodes_in_group(target_group)
	
	if not targets.size() > 0:
		print(owner.name + " did not find any valid targets in " + target_group + " group within range")
		is_complete = true
		return
	
	var closest_distance = max_range
	
	if closest_object == null:
		closest_object = targets[0]
	
	for target in targets:
		var target_distance = buddy.global_position.distance_to(target.global_position)
		if target_distance < closest_distance:
			closest_distance = target_distance
			closest_object = target
	
	if closest_object != null:
		buddy.set_movement_target(closest_object.global_position)
		if buddy.navigation_agent.is_navigation_finished():
			buddy.use_interactor(closest_object)
			is_complete = true

