extends Node

class_name EnemyStateMachine

## The initial state of the state machine. If not set, the first child node is used.
@export var initial_state: statee = null
@onready var player_: Player = null


#Initializes the "state" variable with the first child state if "initial_state" is null
@onready var state: statee = (func get_initial_state() -> statee:
	return initial_state if initial_state != null else get_child(0)
).call()

#Connect the finished signal of a state to the transition function
func _ready() -> void:
	print("STATE_MACHINE From instance = ",self)
	for state_node: statee in find_children("*", "statee"):
		state_node.finished.connect(_transition_to_next_state)
	await owner.ready
	state.enter("")


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _transition_to_next_state(target_state_path: String) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path)


func _on_timer_timeout() -> void:
	#print("timer expired in statemachine")
	state.random_timer_expired()


func _on_kill_zone_body_entered(body: Node2D) -> void:
	print("BODY_ENTERED KILL_ZONE = ", body)
	if body is Player:
		_transition_to_next_state("Attack")


func _on_detect_zone_body_entered(body: Node2D) -> void:
	print("BODY_ENTERED DETECT_ZONE = ", body)
	if body is Player:
		get_child(0).player_ = body
		get_child(1).player_ = body
		get_child(2).player_ = body
		get_child(3).player_ = body
		get_parent().is_chasing = true
		get_parent()._WSS_L_ = get_parent().WalkingSubStates_L.CIRCLING
		_transition_to_next_state("Walking")


func _on_detect_zone_body_exited(body: Node2D) -> void:
	pass
	#print("BODY_EXITED DETECT_ZONE = ", body)
	#if body is Player:
		#state.player_ = null

func _on_bullet_sensitive_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullets"):
		_transition_to_next_state("Hurt")
		var remaining_health = get_parent().prgs_bar.update_health_return_final_health(get_parent().TAKE_DAMAGE)
		if remaining_health == 0:
			print("ENEMY GONE!!!")
			get_parent()._WSS_L_ = get_parent().WalkingSubStates_L.DEAD
			_transition_to_next_state("Idle")
			
		
