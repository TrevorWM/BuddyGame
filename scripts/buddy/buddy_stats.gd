class_name BuddyStats
extends Node

var resource: BuddyResource

# --------------------
# Player Facing Stats
# --------------------
var max_muscle: int
var muscle: int:
	get:
		return muscle
	set(value):
		muscle = clampi(value, 1, resource.max_muscle)

var max_brains: int
var brains: int:
	get:
		return brains
	set(value):
		brains = clampi(value, 1, resource.max_brains)

var max_luck: int
var luck: int:
	get:
		return luck
	set(value):
		luck = clampi(value, 1, resource.max_luck)

var max_zoom: int
var zoom: int:
	get:
		return zoom
	set(value):
		zoom = clampi(value, 1, resource.max_zoom)
		

var max_energy: int
var energy: int:
	get:
		return energy
	set(value):
		energy = clampi(value, 0, resource.max_energy)




# --------------------
# Hidden Stats
# --------------------

var max_affection: int
var affection: int:
	get:
		return affection
	set(value):
		affection = clampi(value, 0, resource.max_affection)
		

var max_boredom: int
var boredom: int:
	get:
		return boredom
	set(value):
		boredom = clampi(value, 0, resource.max_boredom)

var max_hunger: int
var hunger: int:
	get:
		return hunger
	set(value):
		hunger = clampi(value, 0, resource.max_hunger)
		
func initialize(initial_stats: BuddyResource) -> void:
	resource = initial_stats
	
	muscle = initial_stats.muscle
	max_muscle = initial_stats.max_muscle
	
	brains = initial_stats.brains
	max_brains = initial_stats.max_brains
	
	luck = initial_stats.luck
	max_luck = initial_stats.max_luck
	
	zoom = initial_stats.zoom
	max_zoom = initial_stats.max_zoom
	
	energy = initial_stats.energy
	max_energy = initial_stats.max_energy
	
	affection = initial_stats.affection
	max_affection = initial_stats.max_affection
	
	boredom = initial_stats.boredom
	max_boredom = initial_stats.max_boredom
	
	hunger = initial_stats.hunger
	max_hunger = initial_stats.max_hunger

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
