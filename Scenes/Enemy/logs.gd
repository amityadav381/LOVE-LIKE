extends Label

@export var enemy: Enemy

func _process(_delta: float) -> void:
	text = "global"+str(enemy.position)+"\n"\
	 +"last"+str(enemy.position_before_attack)
	pass
