extends statee
class_name EnemyState

const IDLE     = "Idle"
const WALKING  = "Walking"
const ATTACK   = "Attack"
const HURT     = "Hurt"

var rot_clock: int = 0 #Enemy to circle Player Cloclwise
var x_rot:int = 0
var y_rot:int = 0
var jump_in_cnt:int = 0

var enemy: Enemy

func _ready() -> void:
	await owner.ready
	print("AWAIT_READY_CLEARED")
	enemy = owner as Enemy
	rot_clock = randi_range(0, 1) * 2 - 1  # Converts 0 → -1 and 1 → 1
	jump_in_cnt = randi_range(3,6)
	print("ENEMY_JUMP_COUNT = ", jump_in_cnt, "From instance = ",self)
	x_rot = rot_clock
	y_rot = -rot_clock
	assert(enemy != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
 
