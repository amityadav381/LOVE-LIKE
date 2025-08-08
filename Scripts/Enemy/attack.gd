extends EnemyState
class_name Attack
signal burn_zone_active(monitoring_on:bool)

func exit()->void:
	print("left ATTACK state")
	enemy.is_attacking = false
	burn_zone_active.emit(false)
	if enemy._WSS_L_ == enemy.WalkingSubStates_L.GO_FOR_ATTACK:
		enemy._WSS_L_ = enemy.WalkingSubStates_L.RETRACT


func enter(previous_state_path: String) -> void:
	print("entered ATTACK state")
	enemy.is_attacking = true
	burn_zone_active.emit(true)
	await get_tree().create_timer(1).timeout
	finished.emit(IDLE)
	
