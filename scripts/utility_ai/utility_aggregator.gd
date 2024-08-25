class_name UtilityAggregator
extends Node

@export var operation: UtilityAggregator.OPERATION

var children_scores: Array

enum OPERATION {
	SUM,
	MULTIPLY,
	MAX,
	MIN,
	AVERAGE,
}

func combine_scores(scores: Array) -> float:
	var value: float = 0.0
	match operation:
		UtilityAggregator.OPERATION.SUM:
			for score in scores:
				value += score
		UtilityAggregator.OPERATION.MULTIPLY:
			value = 1.0
			for score in scores:
				value *= score
		UtilityAggregator.OPERATION.MAX:
			value = scores.max()
		UtilityAggregator.OPERATION.MIN:
			value = scores.min()
		UtilityAggregator.OPERATION.AVERAGE:
			for score in scores:
				value += score
			value = value/float(scores.size())
		_:
			printerr("No valid operation chosen for " + name)
	return value

func get_score() -> float:
	if get_child_count() < 1:
		printerr("Aggregator " + name + " has no child considerations.")
		return 0.0
	
	var score: float = 0.0
	children_scores.clear()
	
	for child: UtilityConsideration in get_children():
		children_scores.append(child.get_score())
	score = combine_scores(children_scores)
	return score


func print_aggregates() -> void:
	print(children_scores)
