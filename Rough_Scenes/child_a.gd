extends Node2D
var childa := 10
var childa_phy := 10
const CNT_ := 1000
func _ready() -> void:
	print("_ready() of ChildA Node")

func _process(delta: float) -> void:
	while(childa > 0):
		childa = childa - 1
		print("childa = ", childa)
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Process childa ended")
	set_process(false)

func _physics_process(delta: float) -> void:
	while(childa_phy > 0):
		childa_phy = childa_phy - 1
		print("childa_phy = ", childa_phy)
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Physics Process childa ended")
	set_physics_process(false)
