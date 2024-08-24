class_name AIAction
extends Node

@export var must_complete: bool
@export var category: UtilityAgent.CATEGORY

var is_complete: bool = false

func activate_behaviour(_buddy: Buddy) -> void:
	print("No override behaviour set for " + name)
