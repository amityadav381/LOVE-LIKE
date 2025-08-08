extends Area2D

func _ready() -> void:
	monitoring = false

func _on_attack_burn_zone_active(monitoring_on) -> void:
	monitoring = monitoring_on
	print("BURNEDDDDDD = ",monitoring)
