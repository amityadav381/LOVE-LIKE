extends EnemyState
class_name Idle

func exit()->void:
	print("left IDLE state")
	enemy.timer.stop()
	
func enter(previous_state_path: String) -> void:
	print("enter IDLE state")
	if enemy._WSS_L_ == enemy.WalkingSubStates_L.DEAD:
		enemy.is_dead = true
	if player_ != null:
		finished.emit(WALKING)
	else:
		enemy.timer.set_timer(2)
	#enemy._WSS_L_ = enemy.WalkingSubStates_L.CIRCLING
	#print("entered IDLE state. Enemy name = ", enemy.name)

func update(_delta: float) -> void:
	pass

func random_timer_expired()->void:
	#print("Timer expired in IDLE state")
	enemy.direction_of_player = Vector2(randi_range(-1,1), randi_range(-1,1))
	if randi_range(0,1):
		#print("switched to WALKING")
		finished.emit(WALKING)
	else:
		enemy.timer.set_timer(2)
