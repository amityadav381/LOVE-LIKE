extends EnemyState
class_name Attack

func exit()->void:
	print("left ATTACK state")
	enemy.is_attacking = false
	if enemy._WSS_L_ == enemy.WalkingSubStates_L.GO_FOR_ATTACK:
		enemy._WSS_L_ = enemy.WalkingSubStates_L.RETRACT


func enter(previous_state_path: String) -> void:
	print("entered ATTACK state")
	enemy.is_attacking = true
	await get_tree().create_timer(2).timeout
	finished.emit(IDLE)
	
