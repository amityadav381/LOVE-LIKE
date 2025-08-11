extends State

class_name TakeDamage
@export var idle_state:  State
@export var walking_state: State

func enter()->void:
	pass

func exit()->void:
	pass

func input_event(event: InputEvent)->void:
	if event.is_action_released(""):
		player.set_physics_process(true)
		#print("STATE SWITCH STARTED FROM SHOOTING TO IDLE")
		switch_state.emit(self, idle_state)


func _on_hurt_area_area_entered(area: Area2D) -> void:
	print("_on_hurt_area_area_entered = ", area)
	player.health_counter = player.health_counter - player.HEALTH_HIT
	if player.health_counter:
		#Trigger death animation
		pass
	
