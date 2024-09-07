class_name BuddyResource
extends Resource

@export var buddy_name: String
@export var buddy_mesh: PackedScene


@export_category("Player Facing Stats")
@export var max_muscle: int
@export var muscle: int:
	get:
		return muscle
	set(value):
		muscle = clampi(value, 1, max_muscle)

@export var max_brains: int
@export var brains: int:
	get:
		return brains
	set(value):
		brains = clampi(value, 1, max_brains)

@export var max_luck: int
@export var luck: int:
	get:
		return luck
	set(value):
		luck = clampi(value, 1, max_luck)

@export var max_zoom: int
@export var zoom: int:
	get:
		return zoom
	set(value):
		zoom = clampi(value, 1, max_zoom)
		
@export var max_energy: int
@export var energy: int:
	get:
		return energy
	set(value):
		energy = clampi(value, 0, max_energy)

@export_category("Hidden Stats")
@export var max_affection: int
@export var affection: int:
	get:
		return affection
	set(value):
		affection = clampi(value, 0, max_affection)
		
@export var max_boredom: int
@export var boredom: int:
	get:
		return boredom
	set(value):
		boredom = clampi(value, 0, max_boredom)

@export var max_hunger: int
@export var hunger: int:
	get:
		return hunger
	set(value):
		hunger = clampi(value, 0, max_hunger)

func get_muscle_percent() -> float:
	return float(muscle) / float(max_muscle)
	
func get_brains_percent() -> float:
	return float(brains) / float(max_brains)
	
func get_luck_percent() -> float:
	return float(luck) / float(max_luck)
	
func get_zoom_percent() -> float:
	return float(zoom) / float(max_zoom)
	
func get_energy_percent() -> float:
	return float(energy) / float(max_energy)
	
func get_affection_percent() -> float:
	return float(affection) / float(max_affection)
	
func get_boredom_percent() -> float:
	return float(boredom) / float(max_boredom)
	
func get_hunger_percent() -> float:
	return float(hunger) / float(max_hunger)
