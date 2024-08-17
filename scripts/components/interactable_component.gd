class_name InteractableComponent
extends Node3D

@export var hint_text: String
@export var text_label: Label3D
@export var cooldown_timer: Timer

var can_activate: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	text_label.text = hint_text
	text_label.visible = false


func activate(instigator: InteractorComponent):
	if not can_activate:
		return
	
	can_activate = false
	print(instigator.owner.name + " activated: " + owner.name)
	text_label.text = "Interacted with!"
	cooldown_timer.start()


func show_hint_text() -> void:
	text_label.visible = true
	
func hide_hint_text() -> void:
	text_label.visible = false


func _on_interact_cooldown_timeout():
	text_label.text = hint_text
	can_activate = true
