extends Node2D

@onready var live_kroners_reaction: AnimatedSprite2D = $LiveKronersReaction
@onready var reaction: Timer = $Reaction
@onready var next_minigame: Timer = $NextMinigame
@onready var tasks_left: Label = $TasksLeft
@onready var days_left: Label = $DaysLeft
@onready var schedule: VBoxContainer = $Schedule


func _ready() -> void:
	
	Audio.play_music()
	# Kronii Reaction
	if Globals.first_minigame:
		live_kroners_reaction.animation = "default"
	else:
		if Globals.last_minigame_won:
			live_kroners_reaction.animation = "happy"
		else:
			live_kroners_reaction.animation = "angry"
	
	# Update days and tasks left
	if !Globals.first_minigame:
		if Globals.last_minigame_won:
			Globals.tasks_left -= 1
		Globals.days_left -= 1
	
	tasks_left.text = "TASKS LEFT: " + str(Globals.tasks_left)
	days_left.text = "DAYS LEFT: " + str(Globals.days_left)
	
	# Update schedule
	for i in range(Globals.week_minigames.size()):
		schedule.get_child(i).minigame = Globals.week_minigames[i]


func _on_reaction_timeout() -> void:
	
	# Reset Kronii animation
	live_kroners_reaction.animation = "default"
	
	# Pick random minigame
	if Globals.first_minigame: Globals.first_minigame = false
	Globals.current_minigame = Globals.minigames.pick_random()
	
	# Add minigame to schedule
	Globals.week_minigames.append(Globals.current_minigame)
	schedule.get_child(Globals.today).minigame = Globals.current_minigame
	
	next_minigame.start()


func _on_next_minigame_timeout() -> void:
	Globals.last_minigame_won = false
	get_tree().change_scene_to_file(Globals.current_minigame.scene_file)
