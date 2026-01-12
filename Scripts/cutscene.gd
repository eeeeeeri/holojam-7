extends Control

@onready var speaker: Label = $NameTag/Speaker
@onready var message: RichTextLabel = $DialogBox/Message
@onready var timer: Timer = $DialogBox/Timer
@onready var npcs: Node2D = $NPCs

@export var animation_player: AnimationPlayer
@export var json_file : JSON
@export var next_scene : PackedScene
@export var scene := 0

var json
var displayed := false
var visible_char := 0
var has_stop_talking := false

signal shut_up
signal yap(emotion : String)

func _ready() -> void:
	json = json_file.data
	
	for i in npcs.get_children():
		shut_up.connect(i._shut_up)
	
	read()

func _process(delta: float) -> void:
	message.visible_characters = visible_char
	timer.wait_time = lerp(.1,.01,Globals.txt_spd)
	
	if Input.is_action_just_pressed("advance_text"):
		if !displayed:
			visible_char = message.text.length()
			displayed = true
		else:
			if json.size() > scene + 1:
				scene += 1
				read()
			else:
				if next_scene:
					CutoutTransition.transition_scene(next_scene.resource_path)
	
	if displayed:
		stop_talking()

func read() -> void:
	message.visible = false
	displayed = false
	visible_char = 0
	speaker.text = json[scene].speaker
	message.text = json[scene].message
	if json[scene].animation: animation_player.play(json[scene].animation)
	has_stop_talking = false
	timer.start()

func _on_timer_timeout() -> void:
	message.visible = true
	visible_char += 1
	if message.text.length() > visible_char:
		timer.start()
	else:
		displayed = true

func stop_talking() -> void:
	if !has_stop_talking:
		emit_signal("shut_up")
		has_stop_talking = true

func end_game():
	Music.change(Music.Song.SSS)
	Globals.game_ended = true
