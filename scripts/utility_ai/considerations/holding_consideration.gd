class_name HoldingConsideration
extends UtilityConsideration

@export var target_group: String

func score() -> float:
	if buddy.grabber_component.current_object != null:
		if buddy.grabber_component.current_object.is_in_group(target_group):
			return 1.0
	return 0.0
