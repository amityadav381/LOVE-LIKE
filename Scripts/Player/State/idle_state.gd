extends State

class_name IdleState
@export var walking_state:  State
@export var shooting_state: State

func enter()->void:
	player.velocity = Vector2.ZERO
	
func exit()->void:
	pass
	#switch_state.emit(self, )
func input_event(event)->void:
	#print("From IDLE state event = ", event)
	if event.is_action_pressed("shooting"):
		player.is_shooting = true
		player.set_physics_process(false)
		#print("STATE SWITCH STARTED FROM IDLE TO SHOOTING")
		switch_state.emit(self, shooting_state)
	if player.direction != Vector2.ZERO:
		#print("STATE SWITCH STARTED FROM IDLE TO WALKING")
		switch_state.emit(self, walking_state)
