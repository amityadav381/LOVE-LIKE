extends State

class_name ShootingState
@export var idle_state:  State
@export var walking_state: State

func enter()->void:
	player.is_shooting = true
	print("Player state enter SHOOTING")

func exit()->void:
	player.is_shooting = false
	print("Player state exit SHOOTING")
	
func input_event(event: InputEvent)->void:
	if event.is_action_released("shooting"):
		player.set_physics_process(true)
		#print("STATE SWITCH STARTED FROM SHOOTING TO IDLE")
		switch_state.emit(self, idle_state)
