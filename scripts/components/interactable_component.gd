class_name InteractableComponent
extends Node3D

@export var hint_text: String
@export var text_label: Label3D
@export var cooldown_timer: Timer

var can_activate: bool = true
var interactor: InteractorComponent = null

signal activated(instigator: InteractorComponent)

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
	activated.emit(instigator)
	cooldown_timer.start()


func show_hint_text(instigator: InteractorComponent) -> void:
	text_label.visible = true
	interactor = instigator
	
func hide_hint_text() -> void:
	text_label.visible = false
	interactor = null


func _on_interact_cooldown_timeout():
	text_label.text = hint_text
	can_activate = true
