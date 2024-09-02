class_name TugOfWar
extends Node3D

@export var stat_check_timer: Timer

var start_left_muscle: int = 5
var start_left_stam: int = 10

var start_right_muscle: int = 5
var start_right_stam: int = 5

var left_muscle: int = start_left_muscle
var left_stam: int = start_left_stam

var right_muscle: int = start_right_muscle
var right_stam: int = start_right_stam

var left_resting: bool = false
var right_resting: bool = false
var is_rolling: bool = false
var rope_position: int = 50
var left_modifier: int = 0

func _ready():
	stat_check_timer.start()

func _on_stat_check_timeout():
	var left_roll: int = 0
	var right_roll: int = 0
	
	is_rolling = true
	
	if not left_resting:
		left_roll = randi_range(0, left_muscle + left_modifier)
		left_stam -= 1
	
	if not right_resting:
		right_roll = randi_range(0, right_muscle)
		right_stam -= 1
	
	if left_resting:
		left_stam += (1 + left_modifier)
		left_roll = 0
		if left_stam >= ceili(start_left_stam/2):
			left_resting = false

	if right_resting:
		right_stam += (1 + randi_range(0,2))
		right_roll = 0
		if right_stam >= ceili(start_right_stam/2):
			right_resting = false
		
	print("Left: " + str(left_roll) + "/" + str(left_muscle + left_modifier))
	print("Right: " + str(right_roll) + "/" + str(right_muscle))
	
	left_muscle = start_left_muscle
	right_muscle = start_right_muscle
	left_modifier = 0
	
	if left_roll > right_roll:
		print("Left tugs")
		rope_position -= (left_roll - right_roll)
	elif right_roll > left_roll:
		print("Right tugs")
		rope_position += (right_roll - left_roll)
	else:
		print("Tie!")
	
	if left_stam < 1:
		left_resting = true
		
	if right_stam < 1:
		right_resting = true
	
	$PlaceholderLeft/Label3D.text = str(left_stam)
	$PlaceholderRight/Label3D.text = str(right_stam)
	$Label3D.text = "Rope Position\n" + str(rope_position)
	
	if rope_position < 1:
		print("Left Wins!")
		return
	elif rope_position > 99:
		print("Right wins!")
		return
		
	stat_check_timer.start()
	is_rolling = false

func _unhandled_input(event):
	if event.is_action_released("cheer") and not is_rolling:
		left_modifier += 1
	
