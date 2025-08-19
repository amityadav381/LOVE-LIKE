extends Node2D

var childc := 10
var childc_phy := 10
const CNT_ := 1000
func _ready() -> void:
	print("_ready() of ChildC Node")

func _process(delta: float) -> void:
	while(childc > 0):
		childc = childc - 1
		print("childc = ", childc)
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Process childc ended")
	set_process(false)
	
func _physics_process(delta: float) -> void:
	while(childc_phy > 0):
		childc_phy = childc_phy - 1
		print("childc_phy = ", childc_phy)
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Physics Process childc ended")
	set_physics_process(false)
