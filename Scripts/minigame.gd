class_name Minigame extends Node2D

enum InputType {KEYBOARD, MOUSE}

@export var end_timer : Timer
@export var progress_bar: ProgressBar
@export var input_hint: AnimatedSprite2D
@export var input_type: InputType

var scene_file: String
var title: String
var description: String
var progress: float
var done: bool

static func minigame(new_scene_file: String, new_title: String, new_description: String) -> Minigame:
	var new_minigame := Minigame.new()
	new_minigame.scene_file = new_scene_file
	new_minigame.title = new_title
	new_minigame.description = new_description
	return new_minigame

func _ready() -> void:
	progress_bar.max_value = end_timer.wait_time
	
	match input_type:
		InputType.KEYBOARD:
			input_hint.play("keyboard")
		InputType.MOUSE:
			input_hint.play("mouse")

func _process(delta: float) -> void:
	
	if Input.is_anything_pressed():
		input_hint.visible = false
	
	progress = end_timer.wait_time - end_timer.time_left
	progress_bar.value = progress
	
	if end_timer.time_left <= 0:
		# Progress the week
		if Globals.today == Globals.WeekDay.SUN:
			Globals.today = Globals.WeekDay.MON
			Globals.week_minigames.clear()
		else:
			Globals.today += 1
		
		get_tree().change_scene_to_file("res://Scenes/Schedule/main.tscn")
