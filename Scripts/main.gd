extends Node2D

@onready var live_kroners_reaction: AnimatedSprite2D = $LiveKronersReaction
@onready var reaction: Timer = $Reaction
@onready var next_minigame: Timer = $NextMinigame
@onready var tasks_left: Label = $TasksLeft
@onready var days_left: Label = $DaysLeft

@onready var title: Label = $Schedule/Monday/Minigame/Title
@onready var description: Label = $Schedule/Monday/Minigame/Description


func _ready() -> void:
	
	if Globals.first_minigame:
		live_kroners_reaction.animation = "default"
	else:
		if Globals.last_minigame_won:
			live_kroners_reaction.animation = "happy"
		else:
			live_kroners_reaction.animation = "angry"
	
	if Globals.last_minigame_won:
		Globals.tasks_left -= 1
	Globals.days_left -= 1


func _process(delta: float) -> void:
	tasks_left.text = "TASKS LEFT: " + str(Globals.tasks_left)
	days_left.text = "DAYS LEFT: " + str(Globals.days_left)


func _on_reaction_timeout() -> void:
	live_kroners_reaction.animation = "default"
	if Globals.first_minigame: Globals.first_minigame = false
	Globals.current_minigame = Globals.minigames.pick_random()
	title.text = Globals.current_minigame.title
	description.text = Globals.current_minigame.description
	next_minigame.start()


func _on_next_minigame_timeout() -> void:
	get_tree().change_scene_to_file(Globals.current_minigame.scene_file)
