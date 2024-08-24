class_name AIEatFood
extends UtilityAggregator

@onready var find_food = $FindFood
@onready var pickup_food = $PickupFood

func activate_behaviour(buddy: Buddy) -> void:
	is_complete = false
	
	find_food.activate_behaviour(buddy)
	
	if find_food.target_reached:
		pickup_food.activate_behaviour(buddy)
	
	if find_food.target_reached and pickup_food.is_complete:
		buddy.state_text.text = "YUM YUM"
		buddy.stats.energy += 5
		is_complete = true
	
	if is_complete:
		buddy.use_interactor(find_food.nearest_target)
		find_food.nearest_target.queue_free()
