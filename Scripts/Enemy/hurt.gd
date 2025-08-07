extends EnemyState
class_name Hurt

func exit()->void:
	print("left HURT state")
	enemy.is_hurt = false


func enter(previous_state_path: String) -> void:
	print("entered HURT state")
	enemy.is_hurt = true
	await get_tree().create_timer(1).timeout
	finished.emit(IDLE)
