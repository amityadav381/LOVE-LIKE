extends CharacterBody2D
class_name Player


#region New Code Region
const SPEED      := 50.0
const HEALTH     := 100
const HEALTH_HIT := 25
const BULLET_CAPACITY := 4

var health_counter := 25
var bullets_used := 0


var direction         : Vector2   = Vector2.ZERO
var last_direction    : Vector2   = Vector2.ZERO
var direction_discrete: Vector2i  = Vector2i.ZERO


var is_shooting       : bool      = false
var is_dead           : bool      = false
var is_reloading      : bool      = false
var is_hurt           : bool      = false

var input_left        :float      = 0.0
var input_right       :float      = 0.0
var input_up          :float      = 0.0
var input_down        :float      = 0.0
#endregion


#@onready var state_machine: PlayerStateMachine = $PlayerStateMachine 
@onready var c_sm: CallableStateMachine = CallableStateMachine.new()
@onready var PrgBar := $CanvasLayer/ProgressBar
@onready var Tmr    := $Timer
@export var Bullets : PackedScene


func _ready() -> void:
	c_sm.add_states(idle_state, input_idle_state,enter_idle_state, exit_idle_state)
	c_sm.add_states(walking_state, input_walking_state, enter_walking_state, exit_walking_state)
	c_sm.add_states(lockin_state, input_lockin_state, enter_lockin_state, exit_lockin_state)
	c_sm.add_states(shooting_state, input_shooting_state, enter_shooting_state, exit_shooting_state)
	c_sm.add_states(hurt_state, input_hurt_state, enter_hurt_state, exit_hurt_state)
	c_sm.add_states(reload_state, input_reload_state, enter_reload_state, exit_reload_state)
	c_sm.set_initial_state(idle_state)

#region New Code Region
func _on_timer_timeout() -> void:
	print("Timer expired for State::", c_sm.current_state)
	if is_dead:
		get_tree().quit()
	match c_sm.current_state:
		"idle_state":
			pass
		"walking_state":
			pass
		"shooting_state":
			pass
		"hurt_state":
			c_sm.change_state(idle_state)
		"reload_state":
			c_sm.change_state(idle_state)
################################ IDLE ##########################################
func enter_idle_state()->void:
	velocity = Vector2.ZERO
	set_physics_process(false)

func idle_state(delta:float)->void:
	pass

func exit_idle_state()->void:
	set_physics_process(true)

func input_idle_state(event: InputEvent)->void:
	if event.is_action_pressed("freez"):
		c_sm.change_state(lockin_state)
	elif direction:
		c_sm.change_state(walking_state)
################################# WALKING ######################################
func enter_walking_state()->void:
	set_physics_process(true)

func walking_state(delta:float)->void:
	if direction:
		velocity = direction * delta * SPEED * 50
		#print("Walking State:: VELOCITY = ", velocity)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		c_sm.change_state(idle_state)

func exit_walking_state()->void:
	pass

func input_walking_state(event: InputEvent)->void:
	if event.is_action_pressed("freez"):
		c_sm.change_state(lockin_state)

############################ LOCK-IN ##########################################
func enter_lockin_state()->void:
	set_physics_process(false)

func lockin_state(delta:float)->void:
	pass

func exit_lockin_state()->void:
	set_physics_process(true)

func input_lockin_state(event: InputEvent)->void:
	if event.is_action_pressed("shooting"):
		c_sm.change_state(shooting_state)
	elif event.is_action_released("freez"):
		c_sm.change_state(idle_state)
		
############################ SHOOTING ##########################################
func enter_shooting_state()->void:
	is_shooting = true
	set_physics_process(false)

func shooting_state(delta:float)->void:
	pass

func exit_shooting_state()->void:
	is_shooting = false
	set_physics_process(true)

func input_shooting_state(event: InputEvent)->void:
	if event.is_action_released("shooting"):
		c_sm.change_state(idle_state)
	elif event.is_action_released("freez"):
		c_sm.change_state(idle_state)
############################# HURT #############################################
func enter_hurt_state()->void:
	Tmr.start()
	is_hurt = true
	velocity = Vector2.ZERO
	set_physics_process(false)
	var remaning_health = PrgBar.update_health_return_final_health(HEALTH_HIT)
	if (remaning_health == 0):
		is_dead = true
		Tmr.start()

func hurt_state(delta:float)->void:
	pass

func exit_hurt_state()->void:
	is_hurt = false
	set_physics_process(true)

func input_hurt_state(event: InputEvent)->void:
	pass
############################## RELOAD ##########################################
func enter_reload_state()->void:
	is_reloading = true
	set_physics_process(false)
	Tmr.start()

func reload_state(delta:float)->void:
	pass

func exit_reload_state()->void:
	is_reloading = false
	bullets_used = 0
	set_physics_process(true)

func input_reload_state(event: InputEvent)->void:
	pass
################################################################################
#endregion


func get_dir_touch_input() -> void:
	
	#if (Input.is_action_pressed("freez")):
		#set_physics_process(false)
	#else:
		#set_physics_process(true)
	
	input_left   = Input.get_action_strength("move_left")
	input_right  = Input.get_action_strength("move_right")
	input_up     = Input.get_action_strength("move_up")
	input_down   = Input.get_action_strength("move_down")
	direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		).limit_length(1.0)
	#print("TOUCH")

func get_dir_joystick_input() -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down", 0.1)
	direction.normalized()
	#print("JOYSTICK")
 
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventAction:
		#print("unhandled_input called inside player script = ", event)
		get_dir_touch_input()
		#state_machine.input_to_charSM(event)
		#print("EVENT:: ", event," CURR_STATE::",c_sm.current_state)
		c_sm.handle_input(event)
	if event is InputEventJoypadMotion or InputEventJoypadButton:
		#print("Player Controller Input working = ", event)
		get_dir_joystick_input()
		#state_machine.input_to_charSM(event)
		c_sm.handle_input(event)

func _physics_process(delta: float) -> void:
	#print("PHYSICS_PROCESS DIRECTION ===== ", direction)
	c_sm.update(delta)
	move_and_slide()
	
		
func _process(_delta: float) -> void:
	#Save directopm just before direction = 0
	#queue_redraw()
	if direction != Vector2.ZERO:
		last_direction = direction
		
func _draw() -> void:
	#global_position
	draw_line(Vector2.ZERO, (direction)*100, Color.BLANCHED_ALMOND, 10.0, false)
	pass

func _on_controller_ui_attack_interact_pressed() -> void:
	pass

func shoot_bullets_down(position: Vector2, angle: float)->void:
	#This function gets called from the AnimationPlayer
	#I just keep forgetting so wrote it.
	print("current_state = ", c_sm.current_state)
	bullets_used = bullets_used + 1
	if(bullets_used > BULLET_CAPACITY):
		c_sm.change_state(reload_state)
	var shot = Bullets.instantiate()
	shot.bullet_init(position, angle)
	shot.name = "Bullets"
	add_child(shot)



func _on_enemy_burn_zone_active(monitoring_on: bool) -> void:
	c_sm.change_state(hurt_state)
