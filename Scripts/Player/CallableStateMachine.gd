extends Node
class_name CallableStateMachine

var state_dictionary = {}
var current_state: String


func add_states(
	normal_state_callable: Callable,
	input_state_callable: Callable,
	enter_state_callable: Callable,
	leave_state_callable: Callable
):
	state_dictionary[normal_state_callable.get_method()] = {
		"normal": normal_state_callable,
		"input": input_state_callable,
		"enter": enter_state_callable,
		"leave": leave_state_callable
	}


func set_initial_state(state_callable: Callable):
	var state_name = state_callable.get_method()
	if state_dictionary.has(state_name):
		_set_state(state_name)
	else:
		push_warning("No state with name " + state_name)


func update(delta: float):
	if current_state != null:
		print("updateupdate State:: ", current_state)
		(state_dictionary[current_state].normal as Callable).call(delta)

func handle_input(event: InputEvent):
	if current_state != null:
		print("handle_inputhandle_input State:: ", current_state)
		print("handle_inputhandle_input Event:: ", event)
		(state_dictionary[current_state].input as Callable).call(event)


func change_state(state_callable: Callable):
	var state_name = state_callable.get_method()
	print("SWITCHING FROM -----",current_state," TO -----",state_name)
	if state_dictionary.has(state_name):
		_set_state.call(state_name)
	else:
		push_warning("No state with name " + state_name)


func _set_state(state_name: String):
	if current_state:
		var leave_callable = state_dictionary[current_state].leave as Callable
		if !leave_callable.is_null():
			print("Leaving State:: ", current_state)
			leave_callable.call()
	
	current_state = state_name
	var enter_callable = state_dictionary[current_state].enter as Callable
	if !enter_callable.is_null():
		print("Entering State:: ", current_state)
		enter_callable.call()
