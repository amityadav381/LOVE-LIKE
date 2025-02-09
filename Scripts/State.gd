extends Node

class_name State

var next_state:State

@export var player:      CharacterBody2D
signal switch_state

func input_event(event: InputEvent)->void:
	pass

func enter()->void:
	pass
	
func exit()->void:
	pass
