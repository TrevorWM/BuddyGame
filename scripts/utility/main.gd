class_name Main
extends Node

@export var main_menu: PackedScene
@export var testing: bool = false
@export var test_scene: PackedScene

@onready var level_container: Node = %LevelContainer
@onready var ui_container: Control = %UIContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.main_scene = self
	
	if testing:
		add_level_scene(test_scene)
		return
	
	var main_menu_instance = main_menu.instantiate()
	ui_container.add_child(main_menu_instance)

func remove_level_scene() -> void:
	var level_nodes = level_container.get_children()
	
	for node in level_nodes:
		node.queue_free()

func add_level_scene(new_scene: PackedScene) -> void:
	var scene_instance = new_scene.instantiate()
	level_container.add_child(scene_instance)

func change_scenes(new_scene: PackedScene, remove_ui: bool = true) -> void:
	if remove_ui:
		remove_ui_node()
		
	if level_container.get_child_count() > 0:
		remove_level_scene()
		
	add_level_scene(new_scene)

func remove_ui_node() -> void:
	var ui_nodes = ui_container.get_children()
	
	for node in ui_nodes:
		node.queue_free()

func add_ui_node(scene_instance: Control) -> void:
	ui_container.add_child(scene_instance)
	
func hide_ui() -> void:
	for node in ui_container.get_children():
		node.hide()

func show_ui() -> void:
	for node in ui_container.get_children():
		node.show()
		
