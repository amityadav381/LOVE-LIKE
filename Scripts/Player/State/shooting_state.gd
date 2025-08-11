extends State

class_name ShootingState
@export var idle_state:  State
@export var walking_state: State

func enter()->void:
	player.is_shooting = true

func exit()->void:
	player.is_shooting = false
	
func input_event(event: InputEvent)->void:
	if event.is_action_released("shooting"):
		player.set_physics_process(true)
		#print("STATE SWITCH STARTED FROM SHOOTING TO IDLE")
		switch_state.emit(self, idle_state)
