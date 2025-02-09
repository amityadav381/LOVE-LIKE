extends Label

@export var state_machine: PlayerStateMachine

func _process(_delta: float) -> void:
	text = "State: "+ state_machine.current_state.name
