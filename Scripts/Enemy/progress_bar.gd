extends ProgressBar


func _ready() -> void:
	value = 100

func update_health_return_final_health(damage:int)->int:
	value = value - damage
	return value
