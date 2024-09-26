class_name ZoneChanger
extends Node3D

@export var new_scene: PackedScene
@export var level_text: String

func _ready() -> void:
	if level_text.is_empty():
		printerr("No level text given for %s zone changer" % self.name)
		return
	
	$ZoneName.text = level_text

func _on_area_3d_body_entered(body: Node3D) -> void:
	if new_scene == null:
		printerr("No scene connected to %s zone changer." % $ZoneName.text)
		return
	
	if body.is_in_group("Player"):
		Globals.main_scene.change_scenes(new_scene)
