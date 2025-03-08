extends Label

@export var joystick: VirtualJoystick

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventAction:
		text = "TouchMode"
	if event is InputEventJoypadMotion:
		text = "JoystickMode"
		
func _process(_delta: float) -> void:
	#text = "Joystick Output=" + str(joystick.output.length())
	pass
