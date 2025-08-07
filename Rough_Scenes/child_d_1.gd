extends Node2D

var childd1 := 10
var childd1_phy := 10
const CNT_ := 100000000
func _ready() -> void:
	print("_ready() of ChildD1 Node")

func _process(delta: float) -> void:
	while(childd1 > 0):
		childd1 = childd1 - 1
		print("childd1 = ", childd1)
	
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Process childd1 ended")
	set_process(false)
	
func _physics_process(delta: float) -> void:
	while(childd1_phy > 0):
		childd1_phy = childd1_phy - 1
		print("childd1_phy = ", childd1_phy)
		
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Physics Process childd1 ended")
	set_physics_process(false)
