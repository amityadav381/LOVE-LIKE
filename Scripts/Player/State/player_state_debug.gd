extends Label

@export var player: PlayerStateMachine

func _process(_delta: float) -> void:
	text = "State = " + player.current_state.name
