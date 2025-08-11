extends CharacterBody2D
class_name Player


const SPEED      := 50.0
const HEALTH     := 100
const HEALTH_HIT := 25

var health_counter := 25


var direction         : Vector2   = Vector2.ZERO
var last_direction    : Vector2   = Vector2.ZERO
var direction_discrete: Vector2i  = Vector2i.ZERO
var is_shooting       : bool      = false
var is_dead           : bool      = false

var input_left        :float      = 0.0
var input_right       :float      = 0.0
var input_up          :float      = 0.0
var input_down        :float      = 0.0


@onready var state_machine: PlayerStateMachine = $PlayerStateMachine 
@onready var PrgBar := $CanvasLayer/ProgressBar
@export var Bullets : PackedScene

func get_dir_touch_input() -> void:
	
	if (Input.is_action_pressed("freez")):
		set_physics_process(false)
	else:
		set_physics_process(true)
	
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
	#print("Player Main Input working = ", event)
	if event is InputEventAction:
		#print("unhandled_input called inside player script = ", event)
		get_dir_touch_input()
		state_machine.input_to_charSM(event)
	if event is InputEventJoypadMotion or InputEventJoypadButton:
		#print("Player Controller Input working = ", event)
		get_dir_joystick_input()
		state_machine.input_to_charSM(event)

func _physics_process(delta: float) -> void:
	#print("PHYSICS_PROCESS DIRECTION ===== ", direction)
	if direction:
		velocity = direction * delta * SPEED * 50
		#print("VELOCITY = ", velocity)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.x = move_toward(velocity.x, 0, SPEED)
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
	var shot = Bullets.instantiate()
	shot.bullet_init(position, angle)
	shot.name = "Bullets"
	add_child(shot)


func _on_enemy_burn_zone_active(monitoring_on: bool) -> void:
	PrgBar.update_health_return_final_health(HEALTH_HIT)
