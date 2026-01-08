extends Node

enum WeekDay {MON, TUE, WED, THU, FRI, SAT, SUN}

var minigames = [
	# Minigame.minigame("res://Scenes/Minigames/minigame.tscn","Test","Description Test"),
	Minigame.minigame("res://Scenes/Minigames/SuperchatReading/superchat_reading.tscn","Superchat Reading","Read all the Superchats!"),
	Minigame.minigame("res://Scenes/Minigames/Rugpull/rugpull.tscn","Scam with $KRONII","Sell $KRONII at a High!"),
	Minigame.minigame("res://Scenes/Minigames/SpellingBee/spelling_bee.tscn","Spelling Bee","Is actually typing"),
	Minigame.minigame("res://Scenes/Minigames/AddressingAllegations/addressing_allegations.tscn", "Adressing the Allegations","Spot the false allegations"),
	Minigame.minigame("res://Scenes/Minigames/OutfitReveal/outfit_reveal.tscn", "New Outfit Reveal","Showcase your new outfit!"),
]

var week_minigames = []
var week_offlines = []
var first_minigame := true
var minigame_won := false
var last_minigame_won := false
var current_minigame : Minigame
var tasks_left : int = 20
var days_left : int = 30
var today := WeekDay.MON
