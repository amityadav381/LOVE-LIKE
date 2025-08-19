extends Label

@export var player: PlayerStateMachine

func _process(_delta: float) -> void:
	if(player):
		text = "State = " + player.current_state.name
