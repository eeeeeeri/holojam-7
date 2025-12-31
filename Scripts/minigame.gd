extends Node2D

var won := true


func _on_end_timer_timeout() -> void:
	if won:
		Globals.last_minigame_won = true
	else:
		Globals.last_minigame_won = false
	
	if Globals.today == Globals.WeekDay.SUN:
		Globals.today = Globals.WeekDay.MON
		Globals.week_minigames.clear()
	else:
		Globals.today += 1
	
	get_tree().change_scene_to_file("res://Scenes/Schedule/main.tscn")
	
