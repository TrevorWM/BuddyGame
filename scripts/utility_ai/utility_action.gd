class_name UtilityAction
extends Node

@export_group("Action Options")
@export var category: UtilityAgent.CATEGORY = UtilityAgent.CATEGORY.DEFAULT
@export var must_complete: bool

@export_group("Targeting Options")
@export var target_group: String

var is_complete: bool = false
var has_target: bool = false
var target_list: Array = []

func perform_action(_buddy: Buddy) -> void:
	print("No override action set for " + name)

func get_action_score() -> float:
	var action_score: float = 0.0
	var child = get_child(0)
	
	if child is UtilityConsideration or child is UtilityAggregator:
			action_score = child.get_score()
	return action_score * float(category)
