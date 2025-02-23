extends Node2D

var reality = 1
@onready var color_rect = $player/ColorRect  # Make sure this path is correct!

func _input(event):
	if event.is_action_pressed("switch_reality"):  # Shift keybind
		reality = 2 if reality == 1 else 1
		switch_reality(reality)

func switch_reality(new_reality):
	var hide_group = "Reality1" if new_reality == 2 else "Reality2"
	var show_group = "Reality2" if new_reality == 2 else "Reality1"

	# Hide the old reality
	for obj in get_tree().get_nodes_in_group(hide_group):
		obj.visible = false
	
	# Show the new reality
	for obj in get_tree().get_nodes_in_group(show_group):
		obj.visible = true

	# Animate the transition effect
	color_rect.material.set_shader_parameter("transition", 0.0)
	var tween = create_tween()
	tween.tween_property(color_rect.material, "shader_parameter/transition", 1.0, 0.5)
