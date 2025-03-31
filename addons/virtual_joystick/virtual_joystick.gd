class_name VirtualJoystick

extends Control

## A simple virtual joystick for touchscreens, with useful options.
## Github: https://github.com/MarcoFazioRandom/Virtual-Joystick-Godot

# EXPORTED VARIABLE

## The color of the button when the joystick is pressed.
@export var pressed_color := Color.GRAY

## If the input is inside this range, the output is zero.
@export_range(0, 200, 1) var deadzone_size : float = 0.0

## The max distance the tip can reach.
@export_range(0, 500, 1) var clampzone_size : float = 70


@onready var click_timer := $Timer
var double_clicked := false
signal double_tapped

enum Joystick_mode {
	FIXED, ## The joystick doesn't move.
	DYNAMIC, ## Every time the joystick area is pressed, the joystick position is set on the touched position.
	FOLLOWING ## When the finger moves outside the joystick area, the joystick will follow it.
}

## If the joystick stays in the same position or appears on the touched position when touch is started
@export var joystick_mode := Joystick_mode.FIXED

enum Visibility_mode {
	ALWAYS, ## Always visible
	TOUCHSCREEN_ONLY, ## Visible on touch screens only
	WHEN_TOUCHED ## Visible only when touched
}

## If the joystick is always visible, or is shown only if there is a touchscreen
@export var visibility_mode := Visibility_mode.ALWAYS

## If true, the joystick uses Input Actions (Project -> Project Settings -> Input Map)
@export var use_input_actions := true

@export var action_left  := "move_left"
@export var action_right := "move_right"
@export var action_up    := "move_up"
@export var action_down  := "move_down"
@export var action_freez := "freez"
@export var action_shoot := "shooting"

# PUBLIC VARIABLES

## If the joystick is receiving inputs.
var is_pressed := false

# The joystick output.
var output := Vector2.ZERO

# Debug vars
var debug_joystick_center := Vector2.ZERO
var debug_knob_position   := Vector2.ZERO

# PRIVATE VARIABLES

var _touch_index : int = -1

@onready var _base := $Base
@onready var _tip := $Base/Tip
#@onready var _center := $Base/Center


@onready var _base_default_position : Vector2 = _base.position
@onready var _tip_default_position : Vector2 = _tip.position

@onready var _default_color : Color = _tip.modulate

# FUNCTIONS

func _ready() -> void:
	#debug_joystick_center = _center.position
	if ProjectSettings.get_setting("input_devices/pointing/emulate_mouse_from_touch"):
		printerr("The Project Setting 'emulate_mouse_from_touch' should be set to False")
	if not ProjectSettings.get_setting("input_devices/pointing/emulate_touch_from_mouse"):
		printerr("The Project Setting 'emulate_touch_from_mouse' should be set to True")
	
	if not DisplayServer.is_touchscreen_available() and visibility_mode == Visibility_mode.TOUCHSCREEN_ONLY :
		hide()
	
	if visibility_mode == Visibility_mode.WHEN_TOUCHED:
		hide()

func _input(event: InputEvent) -> void:
	#print("Virtual Joystick input workin")
	if event is InputEventScreenTouch:
		#print("Virtual Joystick input touch working")
		event.double_tap
		if event.pressed:
			#print("Virtual Joystick input touch press detected")
			if _is_point_inside_joystick_area(event.position) and _touch_index == -1:
				#print("Virtual Joystick INSIDE ?????")
				print("Event Position = ", event.position)
				if joystick_mode == Joystick_mode.DYNAMIC or joystick_mode == Joystick_mode.FOLLOWING or \
				(joystick_mode == Joystick_mode.FIXED and _is_point_inside_base(event.position)):
					if joystick_mode == Joystick_mode.DYNAMIC or joystick_mode == Joystick_mode.FOLLOWING:
						_move_base(event.position)
					if visibility_mode == Visibility_mode.WHEN_TOUCHED:
						show()
					if(is_double_click()):
						pass
					_touch_index = event.index
					_tip.modulate = pressed_color
					_update_joystick(event.position)
					get_viewport().set_input_as_handled()
		elif event.index == _touch_index:
			_reset()
			reset_double_click()
			if visibility_mode == Visibility_mode.WHEN_TOUCHED:
				hide()
			get_viewport().set_input_as_handled()
	elif event is InputEventScreenDrag:
		if event.index == _touch_index:
			_update_joystick(event.position)
			get_viewport().set_input_as_handled()

func is_double_click()->bool:
	if(click_timer.is_stopped()):
		click_timer.start()
		double_clicked = false
		input_evt_released(action_freez)
		return false
	else:
		double_clicked = true
		input_evt_pressed(action_freez, true, 1)
		#double_tapped.emit()
		return true
func reset_double_click()->void:
	double_clicked = false

func _move_base(new_position: Vector2) -> void:
	_base.global_position = new_position - _base.pivot_offset * get_global_transform_with_canvas().get_scale()

func _move_tip(new_position: Vector2) -> void:
	_tip.global_position = new_position - _tip.pivot_offset * _base.get_global_transform_with_canvas().get_scale()

func _is_point_inside_joystick_area(point: Vector2) -> bool:
	#return Rect2(Vector2.ZERO, size).has_point(point)
	debug_knob_position   = point
	var x: bool = point.x >= global_position.x and point.x <= global_position.x + (size.x * get_global_transform_with_canvas().get_scale().x)
	var y: bool = point.y >= global_position.y and point.y <= global_position.y + (size.y * get_global_transform_with_canvas().get_scale().y)
	return x and y

func _get_base_radius() -> Vector2:
	return _base.size * _base.get_global_transform_with_canvas().get_scale() / 2

func _is_point_inside_base(point: Vector2) -> bool:
	var _base_radius = _get_base_radius()
	var center : Vector2 = _base.global_position + _base_radius
	var vector : Vector2 = point - center
	
	if vector.length_squared() <= _base_radius.x * _base_radius.x:
		return true
	else:
		return false

func _update_joystick(touch_position: Vector2) -> void:
	var _base_radius = _get_base_radius()
	var center : Vector2 = _base.global_position + _base_radius
	var vector : Vector2 = touch_position - center
	vector = vector.limit_length(clampzone_size)
	
	if joystick_mode == Joystick_mode.FOLLOWING and touch_position.distance_to(center) > clampzone_size:
		_move_base(touch_position - vector)
	
	_move_tip(center + vector)
	
	if vector.length_squared() > deadzone_size * deadzone_size:
		is_pressed = true
		output = (vector - (vector.normalized() * deadzone_size)) / (clampzone_size - deadzone_size)
	else:
		is_pressed = false
		output = Vector2.ZERO
	
	##MODIFIED TO SNED _INPUT CALLS TO GAME
	
	if use_input_actions:
	# Release actions
		#print("JOYSTICK OUTPUT STRENGTH = ", output.length())
		if (output.length() < 0.85) and Input.is_action_pressed(action_shoot):
			input_evt_released(action_shoot)
		if output.x >= 0 and Input.is_action_pressed(action_left):
			input_evt_released(action_left)
			#Input.action_release(action_left)
		if output.x <= 0 and Input.is_action_pressed(action_right):
			input_evt_released(action_right)
			#Input.action_release(action_right)
		if output.y >= 0 and Input.is_action_pressed(action_up):
			input_evt_released(action_up)
			#Input.action_release(action_up)
		if output.y <= 0 and Input.is_action_pressed(action_down):
			input_evt_released(action_down)
			#Input.action_release(action_down)
		# Press actions
		if (output.length() >= 0.9) and double_clicked:
			input_evt_pressed(action_shoot, true, 1)
		if output.x < 0:
			input_evt_pressed(action_left, true, -output.x)
			#Input.action_press(action_left, -output.x)
		if output.x > 0:
			input_evt_pressed(action_right, true, output.x)
			#Input.action_press(action_right, output.x)
		if output.y < 0:
			input_evt_pressed(action_up, true, -output.y)
			#Input.action_press(action_up, -output.y)
		if output.y > 0:
			input_evt_pressed(action_down, true, output.y)
			#Input.action_press(action_down, output.y)

	#if use_input_actions:
		## Release actions
		#if output.x >= 0 and Input.is_action_pressed(action_left):
			#Input.action_release(action_left)
		#if output.x <= 0 and Input.is_action_pressed(action_right):
			#Input.action_release(action_right)
		#if output.y >= 0 and Input.is_action_pressed(action_up):
			#Input.action_release(action_up)
		#if output.y <= 0 and Input.is_action_pressed(action_down):
			#Input.action_release(action_down)
		## Press actions
		#if output.x < 0:
			#Input.action_press(action_left, -output.x)
		#if output.x > 0:
			#Input.action_press(action_right, output.x)
		#if output.y < 0:
			#Input.action_press(action_up, -output.y)
		#if output.y > 0:
			#Input.action_press(action_down, output.y)

func input_evt_pressed(event_name:StringName, pressed: bool, strength: float)->void:
	var evt      = InputEventAction.new()
	evt.action   = event_name
	evt.pressed  = pressed
	evt.strength = strength
	#print("Pressed "+event_name+" with strength = ", evt.strength)
	Input.parse_input_event(evt)
	
func input_evt_released(event_name:StringName)->void:
	var evt  = InputEventAction.new()
	evt.action = event_name
	evt.pressed = false
	#print("Released "+event_name)
	Input.parse_input_event(evt)

func _reset():
	is_pressed = false
	output = Vector2.ZERO
	_touch_index = -1
	_tip.modulate = _default_color
	_base.position = _base_default_position
	_tip.position = _tip_default_position
	# Release actions
	if use_input_actions:
		for action in [action_left, action_right, action_down, action_up, action_shoot]:
			if Input.is_action_pressed(action):
				#Input.action_release(action)
				input_evt_released(action)
				
func _process(delta: float) -> void:
	queue_redraw()
func _draw() -> void:
	if double_clicked:
		draw_circle(_base.size/2, 30, Color.WHITE, false, 2.0, true)
	else:
		draw_circle(_base.size/2, 30, Color.DARK_GRAY, false, 2.0, true)
	draw_circle(_tip.position + _tip.size/2, 12, Color.BLACK, false, 2.0, true)
	#print("Tip Position GLOBAL  = ", _tip.global_position)
	#print("Tip Position LOCAL  = ", _tip.position)
	#draw_line(_base.global_position, _tip.global_position, Color.BLUE_VIOLET, 10.0, false)
