extends Label

@export var player: CharacterBody2D

func _process(_delta: float) -> void:
	text = \
	"Left:" + str(player.input_left) + \
	"  ---  Right:" + str(player.input_right) + \
	"  ---  Up:" + str(player.input_up) + \
	"  ---  Down:" + str(player.input_down) 
