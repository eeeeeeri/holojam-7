extends Node2D

@onready var color_rect: ColorRect = $ColorRect

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		color_rect.color = Color.GREEN
		Globals.last_minigame_won = true
