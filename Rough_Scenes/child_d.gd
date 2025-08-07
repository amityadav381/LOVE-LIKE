extends Node2D

var childd := 10
var childd_phy := 10
const CNT_ := 100000000
func _ready() -> void:
	print("_ready() of ChildD Node")

func _process(delta: float) -> void:
	while(childd > 0):
		childd = childd - 1
		print("childd = ", childd)
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Process childd ended")
	set_process(false)
	
func _physics_process(delta: float) -> void:
	while(childd_phy > 0):
		childd_phy = childd_phy - 1
		print("childd_phy = ", childd_phy)
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Physics Process childd ended")
	set_physics_process(false)
