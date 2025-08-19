extends Node2D
var childb := 10
var childb_phy := 10
const CNT_ := 1000
func _ready() -> void:
	print("_ready() of ChildB Node")

func _process(delta: float) -> void:
	while(childb > 0):
		childb = childb - 1
		print("childb = ", childb)
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Process childb ended")
	set_process(false)

func _physics_process(delta: float) -> void:
	while(childb_phy > 0):
		childb_phy = childb_phy - 1
		print("childb_phy = ", childb_phy)
	var cnt = CNT_
	while(cnt>0):
		cnt = cnt - 1
	print("Physics Process childb ended")
	set_physics_process(false)
