extends AnimationTree

var enemy: Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
	active = true


func _process(_delta: float) -> void:
	set_animation("slime_idle", enemy.last_direction)
	set_animation("slime_hurt", enemy.last_direction)
	set_animation("slime_walk", enemy.looking_at)
	set_animation("slime_run", enemy.looking_at)
	set_animation("slime_attack", enemy.looking_at)
	#print("ANIMATION BLEND_POSITION: IDLE = ", enemy.last_direction.x)
	#print("ANIMATION BLEND_POSITION: WALKING = ", enemy.direction_of_player.x)

func set_animation(animation:StringName, direction:Vector2)->void:
	set("parameters/%s/blend_position" %animation, direction)
