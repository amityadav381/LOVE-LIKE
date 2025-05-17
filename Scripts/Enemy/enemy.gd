extends CharacterBody2D
class_name Enemy

const SPEED    := 30.0

var direction         : Vector2   = Vector2.ZERO
var last_direction    : Vector2   = Vector2.ZERO
var direction_discrete: Vector2i  = Vector2i.ZERO
var is_walking        : bool      = false
var is_attacking      : bool      = false

var input_left        :float      = 0.0
var input_right       :float      = 0.0
var input_up          :float      = 0.0
var input_down        :float      = 0.0


@onready var state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var timer : Timer = $Timer
@export var Bullets : PackedScene
