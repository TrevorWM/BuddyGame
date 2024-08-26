class_name EatAction
extends UtilityAction

func perform_action(buddy: Buddy) -> void:
	is_complete = false
	if buddy.grabber_component.current_object != null:
		if buddy.grabber_component.current_object.is_in_group(target_group):
			buddy.use_interactor(buddy.grabber_component.current_object)
			buddy.stats.hunger = buddy.stats.max_hunger
	is_complete = true
