extends EnemyState
class_name Walking
#var EnemySubState:int = 0


func exit()->void:
	print("left WALKING state")
	enemy.timer.stop()
	enemy.is_walking = false
	enemy.velocity = Vector2.ZERO

func enter(previous_state_path: String, data := {}) -> void:
	print("enter WALKING state")
	print("jump_in_cnt = ",jump_in_cnt)
	enemy.is_walking = true
	if player_ == null:
		enemy.timer.set_timer(5)
	#print("entered WALKING state EnemySubState = ", EnemySubState)

func update(_delta: float) -> void:
	if (jump_in_cnt == enemy.wait_jump_in_cnt):
		enemy.wait_jump_in_cnt = 0
		enemy._WSS_L_ = enemy.WalkingSubStates_L.GO_FOR_ATTACK
		enemy.position_before_attack = enemy.position
		print("ENEMY GOING FOR ATTACK  pos = ", enemy.position_before_attack)


func physics_update(_delta: float)->void:
	#print("direction_of_player = ", enemy.direction_of_player)
	enemy.looking_at                = Vector2.ZERO
	if player_ != null:
		enemy.direction_of_player              = player_.position - enemy.position
		if (enemy._WSS_L_ == enemy.WalkingSubStates_L.CIRCLING):
			#print("Entered WalkingSubStates.CIRCLING")
			enemy.looking_at                    = Vector2(x_rot*enemy.direction_of_player.normalized().y, \
			y_rot*enemy.direction_of_player.normalized().x).normalized()
		elif (enemy._WSS_L_ == enemy.WalkingSubStates_L.GO_FOR_ATTACK):
			enemy.looking_at                    = enemy.direction_of_player.normalized()
		elif (enemy._WSS_L_ == enemy.WalkingSubStates_L.RETRACT):
			#print("Entered in WalkingSubStates.RETRACT")
			var temp                    := (enemy.position_before_attack - enemy.position)
			enemy.looking_at             = temp.normalized()
			if(temp.length() < 0.5):
				#print("Switching to WalkingSubStates.CIRCLING")
				enemy._WSS_L_ = enemy.WalkingSubStates_L.CIRCLING
		else:
			printerr("Weird STATE")
	else:
		enemy.looking_at                    = enemy.direction_of_player.normalized()
	#print("enemy.speed = ",enemy.speed)
	enemy.velocity               = enemy.looking_at * _delta * enemy.speed * 50
	print("velocity = ", enemy.velocity)
	enemy.move_and_slide()

func random_timer_expired()->void:
	if enemy.velocity != Vector2.ZERO:
		enemy.last_direction = enemy.direction_of_player
	enemy.velocity.y = move_toward(enemy.velocity.y, 0, enemy.speed)
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, enemy.speed)
	#print("Timer expired in WALKING state")
	finished.emit(IDLE)
	#print("Timer expired in IDLE state")
	#enemy.direction_of_player = Vector2(randi_range(-1,1), randi_range(-1,1))
	#if randi_range(0,1):
		#print("switched to WALKING")
		#finished.emit(WALKING)
	#else:
		#enemy.timer.set_timer()
