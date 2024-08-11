class_name UtilityAgent
extends Node

@export var buddy: Buddy
@export var random_score_max: int = 1

var random_score_min: int = 0

signal scores_updated

var scores: Dictionary

func _ready():
	await owner.ready
	for child in get_children():
		if child is UtilityConsideration:
			child.stats = buddy.stats
			scores[child.name] = child.get_score()
			child.update_curve_x()
	$ScoreUpdateTimer.start()
	
func update_scores() -> void:
	for child in get_children():
		if child is UtilityConsideration:
			scores[child.name] = child.get_score()


func _on_score_update_timer_timeout():
	update_scores()
	print(scores)
	scores_updated.emit()
	
func get_top_score() -> String:
	return scores.find_key(scores.values().max())

func get_semi_random_top_score() -> String:
	var sorted_scores = scores.values()
	sorted_scores.sort_custom(sort_descending)
	return scores.find_key(sorted_scores[randi_range(random_score_min, random_score_max)])

func sort_descending(a, b):
	if a > b:
		return true
	return false
