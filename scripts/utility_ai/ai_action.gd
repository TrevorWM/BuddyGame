class_name AIAction
extends Node

@export var must_complete: bool
@export var requires_target: bool
@export var target_group: String
@export var category: UtilityAgent.CATEGORY


var is_complete: bool = false
var has_target: bool = false
var target_list: Array

func activate_behaviour(_buddy: Buddy) -> void:
	print("No override behaviour set for " + name)
	
func get_targets() -> void:
	var targets = get_tree().get_nodes_in_group(target_group)

	if targets.size() < 1:
		print(owner.name + " did not find any valid targets from " + target_group + " group in tree")
		
	target_list = targets
