extends Node

class_name EnemyStateMachine

## The initial state of the state machine. If not set, the first child node is used.
@export var initial_state: statee = null


#Initializes the "state" variable with the first child state if "initial_state" is null
@onready var state: statee = (func get_initial_state() -> statee:
	return initial_state if initial_state != null else get_child(0)
).call()

#Connect the finished signal of a state to the transition function
func _ready() -> void:
	for state_node: statee in find_children("*", "statee"):
		state_node.finished.connect(_transition_to_next_state)
	await owner.ready
	state.enter("")


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)


func _on_timer_timeout() -> void:
	#print("timer expired in statemachine")
	state.random_timer_expired()
