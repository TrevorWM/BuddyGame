class_name StatConsideration
extends UtilityConsideration

@export var stat: Globals.STAT = Globals.STAT.NONE

func score() -> float:
	var value: float = 0.0
	match stat:
		Globals.STAT.MUSCLE:
			value = buddy.data.get_muscle_percent()
		Globals.STAT.BRAINS:
			value = buddy.data.get_brains_percent()
		Globals.STAT.LUCK:
			value = buddy.data.get_luck_percent()
		Globals.STAT.ZOOM:
			value = buddy.data.get_zoom_percent()
		Globals.STAT.ENERGY:
			value = buddy.data.get_energy_percent()
		Globals.STAT.BOREDOM:
			value = buddy.data.get_boredom_percent()
		Globals.STAT.AFFECTION:
			value = buddy.data.get_affection_percent()
		Globals.STAT.HUNGER:
			value = buddy.data.get_hunger_percent()
		_:
			printerr("Invalid stat chosen for " + name)
	return value
