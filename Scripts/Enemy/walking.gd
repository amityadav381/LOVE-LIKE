extends EnemyState
class_name Walking

func exit()->void:
	enemy.is_walking = false

func enter(previous_state_path: String, data := {}) -> void:
	enemy.timer.set_timer()
	enemy.is_walking = true
	print("entered WALKING state")

func update(_delta: float) -> void:
	#Look for Player and plan to attack him
	#print("printing IDLE state updte function")
	pass

	
func physics_update(_delta: float)->void:
	#print("last_direction = ", enemy.last_direction)
	enemy.velocity = enemy.direction * _delta * enemy.SPEED * 50
	#print("velocity = ", enemy.velocity)
	enemy.move_and_slide()

func random_timer_expired()->void:
	if enemy.velocity != Vector2.ZERO:
		enemy.last_direction = enemy.direction
	enemy.velocity.y = move_toward(enemy.velocity.y, 0, enemy.SPEED)
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, enemy.SPEED)
	print("Timer expired in WALKING state")
	finished.emit(IDLE)
	#print("Timer expired in IDLE state")
	#enemy.direction = Vector2(randi_range(-1,1), randi_range(-1,1))
	#if randi_range(0,1):
		#print("switched to WALKING")
		#finished.emit(WALKING)
	#else:
		#enemy.timer.set_timer()
