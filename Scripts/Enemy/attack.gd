extends EnemyState
class_name Attack


func exit()->void:
	enemy.is_attacking = false
	#enemy.burn_zone_active.emit(false)
	if enemy._WSS_L_ == enemy.WalkingSubStates_L.GO_FOR_ATTACK:
		enemy._WSS_L_ = enemy.WalkingSubStates_L.RETRACT
	print("left ATTACK state = ", enemy._WSS_L_)


func enter(previous_state_path: String) -> void:
	print("entered ATTACK state")
	enemy.is_attacking = true
	enemy.burn_zone_active.emit(true)
	await get_tree().create_timer(1).timeout
	finished.emit(IDLE)
	
