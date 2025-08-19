extends Node2D
var Main_var := 10
var Main_var_phy := 10
const CNT_ := 1000
func _ready() -> void:
	print("_ready() of Main Node")

func _process(delta: float) -> void:
	while(Main_var > 0):
		Main_var = Main_var - 1
		print("Main_var = ", Main_var)

	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Process Main ended")
	set_process(false)

func _physics_process(delta: float) -> void:
	while(Main_var_phy > 0):
		Main_var_phy = Main_var_phy - 1
		print("Main_var_phy = ", Main_var_phy)
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Physics Process Main ended")
	set_physics_process(false)
