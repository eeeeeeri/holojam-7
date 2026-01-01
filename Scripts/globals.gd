extends Node

enum WeekDay {MON, TUE, WED, THU, FRI, SAT, SUN}

var minigames = [
	# Minigame.minigame("res://Scenes/Minigames/minigame.tscn","Test","Description Test"),
	Minigame.minigame("res://Scenes/Minigames/SuperchatReading/superchat_reading.tscn","Superchat Reading","Read all the Superchats!"),
]

var week_minigames = []

var first_minigame := true
var minigame_won := false
var last_minigame_won := false
var current_minigame : Minigame
var tasks_left : int = 20
var days_left : int = 30
var today := WeekDay.MON
