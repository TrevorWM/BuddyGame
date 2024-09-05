class_name TugOfWar
extends Node3D

@export var stat_check_timer: Timer

var left_buddy: BuddyResource
var right_buddy: BuddyResource

var left_current_muscle: int
var left_start_muscle: int
var left_current_energy: int
var left_start_energy: int

var right_current_muscle: int
var right_start_muscle: int
var right_current_energy: int
var right_start_energy: int

var left_resting: bool = false
var right_resting: bool = false
var is_rolling: bool = false

var rope_position: int = 50

var left_modifier: int = 0

var game_state: STATE = STATE.PREGAME
var winner: String = ""

enum STATE {
	PREGAME,
	RUNNING,
	WINNER,
	ENDGAME,
}

func _on_stat_check_timeout():
	var left_roll: int = 0
	var right_roll: int = 0
	
	is_rolling = true
	
	if not left_resting:
		left_roll = randi_range(0, left_current_muscle + left_modifier)
		left_current_energy -= 1
	
	if not right_resting:
		right_roll = randi_range(0, right_current_muscle)
		right_current_energy -= 1
	
	if left_resting:
		left_current_energy += (1 + left_modifier)
		left_roll = 0
		if left_current_energy >= ceili(float(left_start_energy)/2.0):
			left_resting = false

	if right_resting:
		right_current_energy += (1 + randi_range(0,2))
		right_roll = 0
		if right_current_energy >= ceili(float(right_start_energy)/2.0):
			right_resting = false
		
	print("Left: " + str(left_roll) + "/" + str(left_current_muscle + left_modifier))
	print("Right: " + str(right_roll) + "/" + str(right_current_muscle))
	
	left_current_muscle = left_start_muscle
	right_current_muscle = right_start_muscle
	left_modifier = 0
	
	if left_roll > right_roll:
		print("Left tugs")
		rope_position -= (left_roll - right_roll)
	elif right_roll > left_roll:
		print("Right tugs")
		rope_position += (right_roll - left_roll)
	else:
		print("Tie!")
	
	if left_current_energy < 1:
		left_resting = true
		
	if right_current_energy < 1:
		right_resting = true
	
	$PlaceholderLeft/Label3D.text = str(left_current_energy)
	$PlaceholderRight/Label3D.text = str(right_current_energy)
	
	if game_state == STATE.RUNNING:
		$Label3D.text = "Rope Position\n" + str(rope_position)
	
	if rope_position < 1:
		winner = left_buddy.buddy_name
		game_state = STATE.WINNER
		$Label3D.text = winner + " is the winner!"
		return
	elif rope_position > 99:
		winner = right_buddy.buddy_name
		game_state = STATE.WINNER
		$Label3D.text = winner + " is the winner!"
		return
	
	if game_state == STATE.RUNNING:
		stat_check_timer.start()
		is_rolling = false
	

func _unhandled_input(event):
	if event.is_action_released("cheer") and not is_rolling:
		left_modifier += 1

func init_buddy_stats() -> void:
	left_start_muscle = left_buddy.muscle
	left_current_muscle = left_buddy.muscle
	left_current_energy = left_buddy.energy
	left_start_energy = left_buddy.energy
	
	right_start_muscle = right_buddy.muscle
	right_current_muscle = right_buddy.muscle
	right_current_energy = right_buddy.energy
	right_start_energy = right_buddy.energy

func start_game() -> void:
	init_buddy_stats()
	stat_check_timer.start()
	game_state = STATE.RUNNING

func _on_sloth_button_pressed():
	left_buddy = preload("res://assets/resources/sloth_buddy.tres")
	right_buddy = preload("res://assets/resources/dog_buddy.tres")
	$UI.hide()
	start_game()


func _on_dog_button_pressed():
	left_buddy = Globals.current_buddies[1]
	right_buddy = Globals.current_buddies[0]
	$UI.hide()
	start_game()
