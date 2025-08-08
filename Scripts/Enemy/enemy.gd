extends CharacterBody2D
class_name Enemy

const SLOW_SPEEED      := 18.0
const DEFAULT_SPEED    := 35.0
const CHASE_SPEED      := 40.0
var speed              := DEFAULT_SPEED

var direction_of_player   : Vector2   = Vector2.ZERO
var looking_at            : Vector2   = Vector2.ZERO
var last_direction        : Vector2   = Vector2.ZERO
var direction_discrete    : Vector2i  = Vector2i.ZERO
var position_before_attack: Vector2   = Vector2.ZERO

var is_walking        : bool      = false
var is_hurt           : bool      = false
var is_attacking      : bool      = false
var is_chasing        : bool      = false
var player_in_range   : bool      = false

var input_left        :float      = 0.0
var input_right       :float      = 0.0
var input_up          :float      = 0.0
var input_down        :float      = 0.0

var wait_jump_in_cnt  :int        = 0

enum WalkingSubStates_L 
{
	INVALID = 0,
	CIRCLING,
	GO_FOR_ATTACK,
	RETRACT
}
var _WSS_L_  :WalkingSubStates_L = WalkingSubStates_L.INVALID

@onready var state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var timer : Timer = $Timer
@onready var enemy_sprite: Sprite2D = $Sprite2D
@onready var Player: CharacterBody2D = null
@export var Bullets : PackedScene

func _ready() -> void:
	print("ENEMY_READY_CALLED")
	print("ENEMY From instance = ",self)
	_WSS_L_ = WalkingSubStates_L.INVALID

func _init_enemy(pos: Vector2, state: WalkingSubStates_L)->void:
	_WSS_L_ = state
	position = pos
	
func _process(delta: float) -> void:
	queue_redraw()
	if(player_in_range && (_WSS_L_ != WalkingSubStates_L.GO_FOR_ATTACK)):
		print("GlobalEnemy._WSS_ #1= ",_WSS_L_)
		speed           = SLOW_SPEEED
	elif(player_in_range && (_WSS_L_ == WalkingSubStates_L.GO_FOR_ATTACK)):
		print("GlobalEnemy._WSS_ #2=",_WSS_L_)
		speed           = CHASE_SPEED
	else:
		print("GlobalEnemy._WSS_ #3= ",_WSS_L_)
		speed           = DEFAULT_SPEED
	
func _draw() -> void:
	if (\
	((direction_of_player.angle() >= 1.50 && direction_of_player.angle() <= 1.73) ||\
	(direction_of_player.angle() >= 0.56 && direction_of_player.angle() <= 0.72)  ||\
	(direction_of_player.angle() >= -0.05 && direction_of_player.angle() <= 0.11) ||\
	(direction_of_player.angle() >= -0.69 && direction_of_player.angle() <= -0.48)||\
	(direction_of_player.angle() >= -1.60 && direction_of_player.angle() <= -1.40)||\
	(direction_of_player.angle() >= -2.68 && direction_of_player.angle() <= -2.48)||\
	(direction_of_player.angle() >= 3.00 && direction_of_player.angle() <= -3.00) ||\
	(direction_of_player.angle() >= 2.56 && direction_of_player.angle() <= 2.76)) &&\
	is_chasing\
	) \
	:
		player_in_range = true
		print("direction_of_player.angle() = ",direction_of_player.angle())
		draw_circle(Vector2.ZERO, 12, Color.BROWN, false, 0.5, true)
	else:
		if (player_in_range == true) && (_WSS_L_ == WalkingSubStates_L.CIRCLING):
			print("Sector count +1")
			wait_jump_in_cnt += 1
		player_in_range = false
	draw_line(Vector2.ZERO, velocity, Color.AQUA, 2, true)
