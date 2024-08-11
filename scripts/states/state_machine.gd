class_name StateMachine
extends Node

@export var initial_state: State = null

var states: Array[State]
var current_state: State

# Called when the node enters the scene tree for the first time.
func _ready():
	if initial_state == null:
		initial_state = get_child(0)
	
	for state_node: State in get_children():
		states.append(state_node)
		state_node.finished.connect(transition_to_next_state)

	current_state = initial_state
	
	# Wait for the owner to finish their ready function before continuing
	await owner.ready
	assert(current_state)
	current_state.enter(null)

func _unhandled_input(event: InputEvent) -> void:
	if owner is Player:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

func transition_to_next_state(next_state: State) -> void:
	if next_state not in states:
		printerr(owner.name + ": Trying to transition to state " + next_state.name + " but it does not exist.")
		return
	
	current_state.exit()
	next_state.enter(current_state)
	current_state = next_state

