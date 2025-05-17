extends Node

class_name statee

signal finished(next_state_path: String, data: Dictionary)

func enter(previous_state_path: String, data := {})->void:
	pass
	
func exit()->void:
	pass

func random_timer_expired()->void:
	pass

func update(_delta: float)->void:
	pass

func physics_update(_delta: float)->void:
	pass 
