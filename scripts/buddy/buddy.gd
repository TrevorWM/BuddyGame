class_name Buddy
extends CharacterBody3D

@export var buddy_resource: BuddyResource

@export_group("Child Nodes")
@export var utility_agent: UtilityAgent
@export var state_text: Label3D
@export var interactor_component: InteractorComponent
@export var grabber_component: GrabberComponent
@export var audio_player: AudioStreamPlayer3D

@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

var movement_speed: float
var data: BuddyResource = null

func _ready() -> void:
	if data == null:
		data = buddy_resource.duplicate()
	
	var mesh = data.buddy_mesh.instantiate()
	add_child(mesh)
	
	
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	utility_agent.initialize(self, true)
	movement_speed = data.zoom

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _process(_delta):
	if navigation_agent.is_navigation_finished():
		audio_player.stream_paused = true
	else:
		audio_player.stream_paused = false

func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	
	if navigation_agent.avoidance_enabled:
		navigation_agent.velocity = new_velocity
	else:
		_on_velocity_computed(new_velocity)
		
	if velocity != Vector3.ZERO:
		look_at(global_position + Vector3(velocity.x, 0, velocity.z))


func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	move_and_slide()


func use_interactor(target: Node3D) -> void:
	interactor_component.set_target(target)
	
	if grabber_component.is_grabbing:
		interactor_component.interact_with_grabbed(grabber_component)
	else:
		interactor_component.interact()
