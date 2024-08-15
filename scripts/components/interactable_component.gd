class_name InteractableComponent
extends Node3D

@export var hint_text: String
@export var text_label: Label3D

var current_interactor: InteractorComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	text_label.text = ""


func activate(instigator: InteractorComponent):
	print(instigator.owner.name + " activated: " + owner.name)


func _on_area_3d_area_entered(area):
	if area.owner is InteractorComponent:
		current_interactor = area.owner
		text_label.text = hint_text


func _on_area_3d_area_exited(area):
	if area.owner == current_interactor:
		text_label.text = ""
