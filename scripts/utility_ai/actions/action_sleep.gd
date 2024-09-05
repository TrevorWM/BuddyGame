class_name ActionSleep
extends UtilityAction

var buddy: Buddy

func perform_action(buddy_node: Buddy) -> void:
	is_complete = false
	buddy = buddy_node
	create_timer()
	buddy.state_text.text = "SLEEP"
	buddy.set_movement_target(buddy.global_position)

func _on_timer_timeout() -> void:
	buddy.data.energy = buddy.data.max_energy
	is_complete = true
	
func create_timer() -> void:
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.wait_time = (buddy.data.max_energy - buddy.data.energy)
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)
	timer.start()
