extends AnimationTree

@export var player: CharacterBody2D   

func _ready() -> void:
	active = true

func _process(_delta: float) -> void:
	set_animation("idle", player.last_direction)
	set_animation("walk",player.velocity)
	set_animation("idle_shooting",player.last_direction)

func set_condition(condition:StringName, value:bool)->void:
	set("parameters/conditions/%s" %condition, value)
	
func enable_condition(condition:StringName)->void:
	set_condition(condition, true)

func disable_condition(condition:StringName)->void:
	set_condition(condition, false)

func set_animation(animation:StringName, direction:Vector2)->void:
	set("parameters/%s/blend_position" %animation, direction)
