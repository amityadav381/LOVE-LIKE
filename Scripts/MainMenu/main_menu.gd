extends Control


func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/LoveLike/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
