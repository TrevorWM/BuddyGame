class_name UtilityAgent
extends Node

@export var buddy: Buddy
@export var score_update_timer: Timer

signal scores_updated

var scores: Dictionary
var current_action: UtilityAction
var stats: BuddyStatsResource

enum CATEGORY{
	DEFAULT = 1,
	WANT = 2,
	NEED = 3,
}

func _ready():
	await owner.ready
	score_update_timer.start()
	
func update_scores() -> void:
	for child in get_children():
		if child is UtilityAction:
			scores[child.name] = child.get_action_score()

func _on_score_update_timer_timeout():
	update_scores()
	use_top_score_behaviour()
	var stat_string :String = "State %s\n%s"
	$Control/Label.text = stat_string % [current_action.name,scores]
	
func get_top_score() -> String:
	return scores.find_key(scores.values().max())

func get_random_top_score_in_range(deviation: float) -> String:
	var sorted_scores = scores.values()
	sorted_scores.sort_custom(sort_descending)
	var score_min: float = sorted_scores[0] - deviation
	var max_index: int = 0
	for index in range(sorted_scores.size()):
		if sorted_scores[index] > score_min:
			max_index = index
	return scores.find_key(sorted_scores[randi_range(0,max_index)])

func sort_descending(a, b):
	if a > b:
		return true
	return false

func use_top_score_behaviour() -> void:
	if current_action:
		if current_action.must_complete and not current_action.is_complete:
			current_action.perform_action(buddy)
			return
		
	var utility_action: UtilityAction = get_node(get_random_top_score_in_range(0.2))
	current_action = utility_action
	current_action.perform_action(buddy)
