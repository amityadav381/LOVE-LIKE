extends State

class_name Reloading
@export var walking_state:  State
@export var shooting_state: State

func enter()->void:
	print("Player state enter RELOADING")
	player.is_reloading = true
	await get_tree().create_timer(1).timeout
	switch_state.emit(self, reloading)
func exit()->void:
	pass
	#switch_state.emit(self, )
	
