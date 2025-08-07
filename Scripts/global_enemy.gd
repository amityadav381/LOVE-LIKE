extends Node

enum WalkingSubStates 
{
	INVALID = 0,
	CIRCLING,
	GO_FOR_ATTACK,
	RETRACT
}
var _WSS_  :WalkingSubStates = WalkingSubStates.INVALID
