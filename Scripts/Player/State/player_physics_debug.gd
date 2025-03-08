extends Label

@export var player: CharacterBody2D

func _process(_delta: float) -> void:
	text = "Veclocity = " + str(player.velocity.length()) + \
	"\nInput Magnitude = " + str(player.direction.length())

	
	
 
