class_name State
extends Node

@export var can_transition_to: Array[State]

signal finished(next_state: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func handle_input(_event: InputEvent) -> void:
	pass

func update(delta) -> void:
	pass
	
func physics_update(delta) -> void:
	pass
	
func enter(previous_state: State) -> void:
	pass

func exit() -> void:
	pass
