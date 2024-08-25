class_name TargetConsideration
extends UtilityConsideration

@export var action: UtilityAction

func score() -> float:
	if not action:
		printerr("Action not assigned to " + self.name)
		return 0.0
	
	var nodes = get_tree().get_nodes_in_group(action.target_group)
	return 1.0 if nodes.size() > 0 else 0.0
