extends Timer

class_name EnemyTimer

func set_timer()->void:
	start(randi_range(1, 5))
	print("TIMER SET wait time = ", wait_time)
