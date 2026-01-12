extends Node2D

@onready var live_kroners_reaction: AnimatedSprite2D = $CircleMask/LiveKronersReaction
@onready var reaction: Timer = $Reaction
@onready var next_minigame: Timer = $NextMinigame
@onready var tasks_left: Label = $TasksLeft
@onready var days_left: Label = $DaysLeft
@onready var schedule: Node2D = $Schedule
@onready var ok: AudioStreamPlayer = $Ok

var finished := false

func _ready() -> void:
	
	Music.play_tracks(Music.Melody.LOUD_VOX, Music.Drums.FAST)
	# Kronii Reaction
	if Globals.first_minigame:
		live_kroners_reaction.animation = "default"
	else:
		if Globals.last_minigame_won:
			Globals.minigames.erase(Globals.current_minigame)
			live_kroners_reaction.animation = "happy"
		else:
			live_kroners_reaction.animation = "angry"
	
	# Update days and tasks left
	if !Globals.first_minigame:
		var was_offline = true
		if Globals.last_minigame_won:
			Globals.tasks_left -= 1
			was_offline = false
		Globals.week_offlines.append(was_offline)
		Globals.days_left -= 1
	
	tasks_left.text = "TASKS LEFT: " + str(Globals.tasks_left)
	days_left.text = "DAYS LEFT: " + str(Globals.days_left)
	
	# Update schedule
	for i in range(Globals.week_minigames.size()):
		schedule.get_child(i).minigame = Globals.week_minigames[i]
		schedule.get_child(i).offline = Globals.week_offlines[i]
	
	if Globals.minigames.is_empty():
		finished = true


func _on_reaction_timeout() -> void:
	
	# Reset Kronii animation
	live_kroners_reaction.animation = "default"
	
	# Pick random minigame
	if !finished:
		if Globals.first_minigame: Globals.first_minigame = false
		Globals.current_minigame = Globals.minigames.pick_random()
		
		# Add minigame to schedule
		Globals.week_minigames.append(Globals.current_minigame)
		schedule.get_child(Globals.today).minigame = Globals.current_minigame
	else:
		schedule.get_child(Globals.today).finished = true
		Globals.gauntlet = true
		Globals.all_minigames.pop_at(1)
		for i in range(5):
			var new_minigame = Globals.all_minigames.pick_random()
			Globals.all_minigames.erase(new_minigame)
			Globals.gauntlet_minigames.append(new_minigame)
	
	ok.play()
	
	next_minigame.start()


func _on_next_minigame_timeout() -> void:
	Globals.last_minigame_won = false
	if !finished:
		CutoutTransition.transition_scene(Globals.current_minigame.scene_file)
	else:
		Globals.gauntlet_lifes = 2
		CutoutTransition.transition_scene(Globals.gauntlet_minigames[Globals.gauntlet_current].scene_file)
