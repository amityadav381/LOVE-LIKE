extends Area2D

@export var speed := 180
var bullet_direction := Vector2(1.0,1.0)


func _physics_process(delta: float) -> void:
	position = position + bullet_direction*speed*delta

func bullet_init(_position: Vector2, angle: float)->void:
	bullet_direction = Vector2.from_angle(angle)
	position = _position

func _on_timer_timeout() -> void:
	queue_free()
