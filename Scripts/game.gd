extends Node2D
#var mouse_pos := Vector2.ZERO
#var enemy_scene :PackedScene = preload("res://Scenes/Enemy/enemy.tscn")
#
	#
#
##func _draw() -> void:
	##draw_circle(mouse_pos, 10.0, Color.BLUE, false, 5, true)
	#
#func _input(event):
	## Mouse in viewport coordinates.
	#if event.is_action_pressed("left_mouse_click"):
		#mouse_pos = event.position
		#print("Mouse Click/Unclick at: ", event.position)
		##queue_redraw()
		#var enemy_instance = enemy_scene.instantiate()
		#enemy_instance._init_enemy(mouse_pos, GlobalEnemy.WalkingSubStates.CIRCLING)
		#add_child(enemy_instance)
		#
	##elif event is InputEventMouseMotion:
		##print("Mouse Motion at: ", event.position)
#
	## Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
