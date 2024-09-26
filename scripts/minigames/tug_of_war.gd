class_name TugOfWar
extends Node3D

@export var stat_check_timer: Timer
@export var tug_of_war_ui: PackedScene

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

func _ready() -> void:
	if not Globals.main_scene:
		printerr("%s could not find main scene" % self.name)
		return
	
	var ui_instance = tug_of_war_ui.instantiate()
	ui_instance.init()
	Globals.main_scene.add_ui_node(ui_instance)
	SignalBus.buddy_selected.connect(buddy_selected)

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
		$PlaceholderLeft.position.x -= (left_roll - right_roll) * 0.05
		$PlaceholderRight.position.x -= (left_roll - right_roll) * 0.05
	elif right_roll > left_roll:
		print("Right tugs")
		rope_position += (right_roll - left_roll)
		$PlaceholderLeft.position.x += (right_roll - left_roll) * 0.05
		$PlaceholderRight.position.x += (right_roll - left_roll) * 0.05
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
	
	if left_buddy.buddy_mesh:
		$PlaceholderLeft.add_child(left_buddy.buddy_mesh.instantiate())
	
	right_start_muscle = right_buddy.muscle
	right_current_muscle = right_buddy.muscle
	right_current_energy = right_buddy.energy
	right_start_energy = right_buddy.energy
	
	if right_buddy.buddy_mesh:
		$PlaceholderRight.add_child(right_buddy.buddy_mesh.instantiate())

func buddy_selected(buddy_resource: BuddyResource) -> void:
	print("Game sees you selected a buddy!")
	
	# Disconnect from the signal to prevent weird things from happening
	SignalBus.buddy_selected.disconnect(buddy_selected)
	
	left_buddy = buddy_resource
	right_buddy = Globals.current_buddies.pick_random()
	start_game()

func start_game() -> void:
	Globals.main_scene.hide_ui()
	init_buddy_stats()
	stat_check_timer.start()
	game_state = STATE.RUNNING
