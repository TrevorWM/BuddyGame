class_name UtilityConsideration
extends Node

@export var buddy: Buddy
@export var score_curve: Curve

func get_score() -> float:
	return apply_curve(score())
	
func apply_curve(value: float) -> float:
	return score_curve.sample_baked(value)
	
func score() -> float:
	printerr("No score override given for consideration: %s" % self.name)
	return 0.0
