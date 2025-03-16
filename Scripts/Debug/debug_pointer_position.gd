extends Label

@export var joystick: VirtualJoystick

#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventAction:
		#text = "TouchMode"
	#if event is InputEventJoypadMotion:
		#text = "JoystickMode"
		
func _process(_delta: float) -> void:
	text = "Pointer_Position =" + str(get_global_mouse_position())\
	+"\n Touch Event Position = " + str(joystick.debug_knob_position)\
	+"\n Tip local position = " + str(joystick._tip.position)\
	+"\n Tip Global position = " + str(joystick._tip.global_position)
	global_position = get_global_mouse_position()
