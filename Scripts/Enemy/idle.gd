extends EnemyState
class_name Idle

func exit()->void:
	pass
func enter(previous_state_path: String, data := {}) -> void:
	enemy.is_walking = false
	enemy.timer.set_timer()
	print("entered IDLE state. Enemy name = ", enemy.name)

func update(_delta: float) -> void:
	#print("printing IDLE state updte function")
	pass


func random_timer_expired()->void:
	print("Timer expired in IDLE state")
	enemy.direction = Vector2(randi_range(-1,1), randi_range(-1,1))
	if randi_range(0,1):
		#print("switched to WALKING")
		finished.emit(WALKING)
	else:
		enemy.timer.set_timer()
