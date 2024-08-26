class_name StatConsideration
extends UtilityConsideration

@export var stat: Globals.STAT = Globals.STAT.NONE

func score() -> float:
	var value: float = 0.0
	match stat:
		Globals.STAT.MUSCLE:
			value = float(buddy.stats.muscle) / float(buddy.stats.max_muscle)
		Globals.STAT.BRAINS:
			value = float(buddy.stats.brains) / float(buddy.stats.max_brains)
		Globals.STAT.LUCK:
			value = float(buddy.stats.luck) / float(buddy.stats.max_luck)
		Globals.STAT.ZOOM:
			value = float(buddy.stats.zoom) / float(buddy.stats.max_zoom)
		Globals.STAT.ENERGY:
			value = float(buddy.stats.energy) / float(buddy.stats.max_energy)
		Globals.STAT.BOREDOM:
			value = float(buddy.stats.boredom) / float(buddy.stats.max_boredom)
		Globals.STAT.AFFECTION:
			value = float(buddy.stats.affection) / float(buddy.stats.max_affection)
		Globals.STAT.HUNGER:
			value = float(buddy.stats.hunger) / float(buddy.stats.max_hunger)
		_:
			printerr("Invalid stat chosen for " + name)
	return value
