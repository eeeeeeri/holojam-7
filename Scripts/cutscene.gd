extends Control

@onready var name_tag: Panel = $NameTag
@onready var speaker: Label = $NameTag/Speaker
@onready var message: RichTextLabel = $DialogBox/Message
@onready var timer: Timer = $DialogBox/Timer
@onready var arrow: Sprite2D = $Arrow

@export var animation_player: AnimationPlayer
@export var json_file : JSON
@export var next_scene : PackedScene
@export var scene := 0
@export var npcs : Array[AnimatedSprite2D]
@export var start := false

var json
var displayed := false
var visible_char := 0
var has_stop_talking := false

signal shut_up
signal yap(emotion : String)

func _ready() -> void:
	json = json_file.data
	
	for i in npcs:
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
					goto_next_scene()
	
	if displayed:
		arrow.visible = true
		stop_talking()
	else:
		arrow.visible = false

func read() -> void:
	message.visible = false
	displayed = false
	visible_char = 0
	
	if json[scene].speaker == "no_speaker":
		name_tag.visible = false
	else:
		speaker.text = json[scene].speaker
		name_tag.visible = true
	
	message.text = json[scene].message
	if json[scene].animation: animation_player.play(json[scene].animation)
	has_stop_talking = false
	timer.start()

func _on_timer_timeout() -> void:
	message.visible = true
	visible_char += 1
	if message.text.length() >= visible_char:
		timer.start()
	else:
		displayed = true

func stop_talking() -> void:
	if !has_stop_talking:
		emit_signal("shut_up")
		has_stop_talking = true

func goto_next_scene():
	if start: start_game()
	CutoutTransition.transition_scene(next_scene.resource_path)

func start_game():
	Music.change(Music.Song.SNM)

func no_music():
	Music.stop()

func cutscene_music():
	Music.change(Music.Song.SNM)
	Music.play_tracks(Music.Melody.QUIET_SPACE,Music.Drums.SLOW)

func end_game():
	Music.change(Music.Song.SSS)
	Globals.game_ended = true


func _on_skip_button_button_down() -> void:
	goto_next_scene()
