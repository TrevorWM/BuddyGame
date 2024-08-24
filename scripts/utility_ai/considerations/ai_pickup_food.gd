class_name AIPickupFood
extends UtilityConsideration

@export var target_finder: AIFind

func activate_behaviour(buddy: Buddy) -> void:
	is_complete = false
	buddy.state_text.text = "PICKING UP FOOD"
	buddy.use_interactor(target_finder.nearest_target)
	
	if buddy.grabber_component.is_grabbing:
		is_complete = true

func update_curve_x() -> void:
	curve_x = target_finder.nearest_distance/target_finder.max_range
