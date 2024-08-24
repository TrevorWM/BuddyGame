class_name Buddy
extends CharacterBody3D

enum BUDDY_STATE{
	IDLE,
	WANDER,
	SLEEP,
}

@export var wander_radius: float = 5.0
@export var stats: BuddyStatsResource
@export var utility_agent: UtilityAgent
@export var state_text: Label3D

@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

var state = BUDDY_STATE.IDLE
var movement_speed: float

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	movement_speed = stats.zoom

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

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

func get_random_nearby_position() -> Vector3:
	return Vector3(
				randf_range(-wander_radius, wander_radius), 
				0, 
				randf_range(-wander_radius, wander_radius))
