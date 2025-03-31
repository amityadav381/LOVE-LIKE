extends CanvasLayer

signal attack_interact_pressed


func _on_virtual_joystick_double_tapped() -> void:
	attack_interact_pressed.emit()
