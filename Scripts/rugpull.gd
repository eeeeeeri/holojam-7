extends Node2D

@onready var line_2d: Line2D = $Line2D
@onready var sell_button: TextureButton = $SellButton
@onready var yes_dollar: CPUParticles2D = $YesDollar
@onready var no_dollar: CPUParticles2D = $NoDollar
@onready var minigame: Minigame = $".."
var step := 0
var value := 96
var last_value := 96
var has_reached_min := false

func _on_clock_timeout() -> void:
	if has_reached_min:
		value = clamp(randi_range(last_value - 32, last_value + 32), 0, 112)
	else:
		value = clamp(randi_range(last_value - 32, last_value + 4), 0, 112)
	line_2d.add_point(Vector2(step * 16, value))
	last_value = value
	if value <= 48:
		has_reached_min = true
	step += 1


func _on_sell_button_button_up() -> void:
	if value <= 48 or last_value <= 48:
		Globals.last_minigame_won = true
		yes_dollar.visible = true
	else:
		no_dollar.visible = true
	minigame.done = true
	sell_button.disabled = true
