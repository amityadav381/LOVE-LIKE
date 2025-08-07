extends Timer

class_name EnemyTimer

func set_timer(max_sec: int)->void:
	start(randi_range(1, max_sec))
	#print("TIMER SET wait time = ", wait_time)
