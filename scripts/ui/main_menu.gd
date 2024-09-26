class_name MainMenu
extends Control

@export var new_game_scene: PackedScene

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_new_game_pressed() -> void:
	if Globals.main_scene != null:
		Globals.main_scene.change_scenes(new_game_scene)
