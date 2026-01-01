class_name Minigame extends Node2D

var scene_file: String
var title: String
var description: String
var played: bool

@export var end_timer : Timer

static func minigame(new_scene_file: String, new_title: String, new_description: String) -> Minigame:
	var new_minigame := Minigame.new()
	new_minigame.scene_file = new_scene_file
	new_minigame.title = new_title
	new_minigame.description = new_description
	return new_minigame

func _process(delta: float) -> void:
	if end_timer.time_left <= 0:
		
		# Progress the week
		if Globals.today == Globals.WeekDay.SUN:
			Globals.today = Globals.WeekDay.MON
			Globals.week_minigames.clear()
		else:
			Globals.today += 1
		
		get_tree().change_scene_to_file("res://Scenes/Schedule/main.tscn")
