extends CharacterBody2D


const UP_SPEED := 200.0
const DOWN_SPEED := 50.0

var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO
var direction_discrete: Vector2i = Vector2i.ZERO
var is_shooting: bool = false


@onready var state_machine: PlayerStateMachine = $PlayerStateMachine 


func get_dir_input() -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction.normalized()

func _unhandled_input(event: InputEvent) -> void:
	get_dir_input()
	state_machine.input_to_charSM(event)

func _physics_process(delta: float) -> void:
	if direction :
		velocity = direction * delta * UP_SPEED * 50
	else:
		velocity.y = move_toward(velocity.y, 0, UP_SPEED)
		velocity.x = move_toward(velocity.x, 0, DOWN_SPEED)
	move_and_slide()
	
		
func _process(_delta: float) -> void:
	#Save directopm just before direction = 0
	if direction != Vector2.ZERO:
		last_direction = direction
