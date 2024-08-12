class_name BuddyStatsResource
extends Resource

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
