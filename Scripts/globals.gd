extends Node

var minigames = [
	Minigame.minigame("res://Scenes/Minigames/minigame.tscn","Test","Description Test")
]

var first_minigame := true
var last_minigame_won := false
var current_minigame : Minigame
var tasks_left : int = 20
var days_left : int = 30
