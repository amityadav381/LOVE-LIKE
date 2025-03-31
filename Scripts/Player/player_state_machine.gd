extends Node

class_name PlayerStateMachine

var states: Dictionary = {}

@export var player: CharacterBody2D
@export var current_state:State


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.player       = player
			child.switch_state.connect(on_state_switch)
		else:
			push_warning("Child - " + child.name + "is not a State for PlayerStateMachine")
	if current_state:
		current_state.enter()

func input_to_charSM(event: InputEvent)->void:
	#print("From SM state event = ", event)
	current_state.input_event(event)
		
func on_state_switch(state: State, next_state:State)->void:
	if state != current_state:
		return
		
	if next_state == null:
		return
		
	current_state.exit()
	current_state = next_state
	current_state.enter()
