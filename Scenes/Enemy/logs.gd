extends Label

@export var enemy: Enemy

func _process(_delta: float) -> void:
	#text = str(enemy.GlobalEnemy._WSS_) ##problem is each enemy doesn't have its own copy of this global state
	pass
