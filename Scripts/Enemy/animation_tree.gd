extends AnimationTree

var enemy: Enemy

func _ready() -> void:
	await owner.ready
	enemy = owner as Enemy
	assert(enemy != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
	active = true


func _process(_delta: float) -> void:
	set_animation("slime_idle", enemy.last_direction.x)
	set_animation("slime_walking", enemy.direction.x)
	#print("ANIMATION BLEND_POSITION: IDLE = ", enemy.last_direction.x)
	#print("ANIMATION BLEND_POSITION: WALKING = ", enemy.direction.x)

func set_animation(animation:StringName, direction:float)->void:
	set("parameters/%s/blend_position" %animation, direction)
