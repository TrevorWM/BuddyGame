class_name UtilityAgent
extends Node

@export var score_update_timer: Timer
@export var show_debug: bool = false
@export var top_score_random_threshold: float

var scores: Dictionary
var current_action: UtilityAction
var buddy: Buddy

enum CATEGORY{
	DEFAULT = 1,
	WANT = 2,
	NEED = 3,
}

func initialize(owning_buddy: Buddy, start_ai: bool) -> void:
	buddy = owning_buddy as Buddy
	
	if buddy == null:
		printerr("Utility agent failed to initialize. Buddy is null")
		return
	
	if start_ai:
		score_update_timer.start()
	
func stop_ai() -> void:
	score_update_timer.stop()
	
func update_scores() -> void:
	for child in get_children():
		if child is UtilityAction:
			scores[child.name] = child.get_action_score()

func _on_score_update_timer_timeout():
	update_scores()
	use_top_score_behaviour()
	if show_debug:
		show_scores_debug()
	
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
		
	var utility_action: UtilityAction = get_node(get_random_top_score_in_range(top_score_random_threshold))
	current_action = utility_action
	current_action.perform_action(buddy)

func show_scores_debug() -> void:
	var stat_string :String = "AI Debug\n"
	stat_string += "Current Action: " + str(current_action.name) + "\n"
	for action in scores:
		stat_string += "%s: %s\n" % [action, scores[action]]
	$Control/Label.text = stat_string
