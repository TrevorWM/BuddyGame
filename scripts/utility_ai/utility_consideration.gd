class_name UtilityConsideration
extends Node

@export var stat: Globals.STAT
@export var score_curve: Curve

var curve_x: float
var stats: BuddyStatsResource

func _process(_delta) -> void:
	update_curve_x()

func get_score() -> float:
	return score_curve.sample_baked(curve_x)

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
		_:
			value = 0.0
	curve_x = value
