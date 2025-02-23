extends Node2D

func _process(delta: float) -> void:
	if Global.CurrentReality == 2:
		show()
		position = Vector2(0, 0)
		
	else:
		hide()
		position = Vector2(99999, 99999)
