extends Node2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var reality = 0
func _process(delta: float) -> void:
	if Global.CurrentReality != reality:
		change_reality()

func change_reality():
	if Global.CurrentReality == 2:
		reality = 2
		animation.play("fadeIn")
		position = Vector2(0, 0)

	else:
		reality = 1
		animation.play("fadeOut")
		await animation.animation_finished
		position = Vector2(99999, 99999)
