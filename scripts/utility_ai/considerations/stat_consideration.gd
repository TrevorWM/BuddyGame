class_name StatConsideration
extends UtilityConsideration

@export var stat: Globals.STAT = Globals.STAT.NONE

func score() -> float:
	var value: float = 0.0
	match stat:
		Globals.STAT.MUSCLE:
			value = buddy.stats.get_muscle_percent()
		Globals.STAT.BRAINS:
			value = buddy.stats.get_brains_percent()
		Globals.STAT.LUCK:
			value = buddy.stats.get_luck_percent()
		Globals.STAT.ZOOM:
			value = buddy.stats.get_zoom_percent()
		Globals.STAT.ENERGY:
			value = buddy.stats.get_energy_percent()
		Globals.STAT.BOREDOM:
			value = buddy.stats.get_boredom_percent()
		Globals.STAT.AFFECTION:
			value = buddy.stats.get_affection_percent()
		Globals.STAT.HUNGER:
			value = buddy.stats.get_hunger_percent()
		_:
			printerr("Invalid stat chosen for " + name)
	return value
