class_name UtilityConsideration
extends Node

@export var must_complete: bool
@export var stat: Globals.STAT
@export var category: UtilityAgent.CATEGORY
@export var score_curve: Curve

var curve_x: float
var stats: BuddyStatsResource
var is_complete: bool = true

func get_score() -> float:
	update_curve_x()
	return (score_curve.sample_baked(curve_x) * float(category))

func update_curve_x() -> void:
	var value: float = 0.0
	match stat:
		Globals.STAT.MUSCLE:
			value = float(stats.muscle) / float(stats.max_muscle)
		Globals.STAT.BRAINS:
			value = float(stats.brains) / float(stats.max_brains)
		Globals.STAT.LUCK:
			value = float(stats.luck) / float(stats.max_luck)
		Globals.STAT.ZOOM:
			value = float(stats.zoom) / float(stats.max_zoom)
		Globals.STAT.ENERGY:
			value = float(stats.energy) / float(stats.max_energy)
		Globals.STAT.BOREDOM:
			value = float(stats.boredom) / float(stats.max_boredom)
		Globals.STAT.AFFECTION:
			value = float(stats.affection) / float(stats.max_affection)
		_:
			printerr("Invalid stat chosen for " + name)
	curve_x = value

func activate_behaviour(_buddy: Buddy) -> void:
	pass
