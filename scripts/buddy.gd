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

@onready var navigation_agent: NavigationAgent3D = get_node("NavigationAgent3D")

var state = BUDDY_STATE.IDLE
var movement_speed: float

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	$StateText.text = BUDDY_STATE.keys()[state]
	$MeshInstance3D.get_active_material(0).albedo_color = Color.GREEN_YELLOW
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

func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	move_and_slide()

func _on_utility_agent_scores_updated():
	var top_score: String = utility_agent.get_random_top_score_in_range()
	
	if state == BUDDY_STATE.SLEEP or top_score == "Sleep":
		set_movement_target(global_position)
		state = BUDDY_STATE.SLEEP
		$StateText.text = BUDDY_STATE.keys()[state]
		$MeshInstance3D.get_active_material(0).albedo_color = Color.BLUE_VIOLET
		stats.energy += 1
		if stats.energy == stats.max_energy:
			state = BUDDY_STATE.IDLE
		return
		
	if top_score == "Wander" and not state == BUDDY_STATE.SLEEP:
		state = BUDDY_STATE.WANDER
		$StateText.text = BUDDY_STATE.keys()[state]
		stats.energy -= 1
		$MeshInstance3D.get_active_material(0).albedo_color = Color.DODGER_BLUE
		
		if navigation_agent.is_navigation_finished():
			var random_position = Vector3(
				randf_range(-wander_radius, wander_radius), 
				0, 
				randf_range(-wander_radius, wander_radius))
			set_movement_target(random_position)
		
	if top_score == "Idle":
		set_movement_target(global_position)
		state = BUDDY_STATE.IDLE
		$StateText.text = BUDDY_STATE.keys()[state]
		$MeshInstance3D.get_active_material(0).albedo_color = Color.GREEN_YELLOW
