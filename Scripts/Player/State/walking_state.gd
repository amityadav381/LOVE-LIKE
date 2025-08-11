extends State

class_name WalkingState
@export var idle_state:  State
@export var shooting_state: State


func exit():
	player.velocity = Vector2.ZERO
	
func enter():
	pass
	
func input_event(event)->void:
	if player.direction == Vector2.ZERO:
		#print("STATE SWITCH STARTED FROM WALKING TO IDLE")
		switch_state.emit(self, idle_state)
	if event.is_action_pressed("shooting"):
		player.set_physics_process(false)
		#print("STATE SWITCH STARTED FROM IDLE TO SHOOTING")
		switch_state.emit(self, shooting_state)
		
		
