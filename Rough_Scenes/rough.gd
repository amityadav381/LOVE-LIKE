extends Node2D


func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("move_up") or event.is_action_pressed("move_down"):
		#print("_input() 1---->" + event.as_text())
		#var count = 100000000
		#while count > 0:
			#count = count - 1
		#print("_input() 2---->" + event.as_text())
		
	if event.is_action_pressed("shooting"):
		print("_input() 1---->" + event.as_text())
		var count = 100000000
		while count > 0:
			count = count - 1
		if event.is_action_pressed("shooting"):
			print("_input() 2---->" + event.as_text())
	if event.is_action_pressed("move_down"):
		print("_input() 1---->" + event.as_text())

	#if Input.is_action_pressed("move_up"):
		##print("_process() - MOVE-UP, delta = ",delta)
		#var count = 100000000
		#while count > 0:
			#count = count - 1
		#if Input.is_action_pressed("move_up"):
			#print("_process() - MOVE-UP AGAIN")
		#
	#if Input.is_action_pressed("move_down"):
		#print("_process() - MOVE-DOWN")
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_up"):
		#print("_process() - MOVE-UP, delta = ",delta)
		var count = 100000000
		while count > 0:
			count = count - 1
		if Input.is_action_pressed("move_up"):
			print("_process() - MOVE-UP AGAIN, delta = ",delta)
		
	if Input.is_action_pressed("move_down"):
		print("_process() - MOVE-DOWN, delta = ",delta)
