extends Node

var CurrentReality = 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_reality"):
		if CurrentReality == 1:
			CurrentReality = 2

		else:
			CurrentReality = 1
