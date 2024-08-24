class_name InteractableComponent
extends Node3D

@export var hint_text: String
@export var interacted_text: String
@export var text_label: Label3D
@export var cooldown_timer: Timer

var can_activate: bool = true
var interactor: InteractorComponent = null

signal activated(instigator: InteractorComponent)

# Called when the node enters the scene tree for the first time.
func _ready():
	text_label.text = hint_text
	text_label.visible = false

func activate(instigator: InteractorComponent) -> bool:
	if not can_activate:
		return false
	
	can_activate = false
	
	print(instigator.owner.name + " activated: " + owner.name)
	text_label.text = interacted_text
	interactor = instigator
	activated.emit(instigator)
	can_activate = true
	return true


func show_hint_text(instigator: InteractorComponent) -> void:
	interactor = instigator
	
	if not text_label:
		printerr("No hint text label to show on " + owner.name)
		return
	
	text_label.text = hint_text
	text_label.visible = true
	
func hide_hint_text() -> void:
	interactor = null
	
	if not text_label:
		printerr("No hint text label to hide on " + owner.name)
		return
	
	text_label.visible = false
