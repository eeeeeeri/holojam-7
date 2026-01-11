extends Control

@onready var speaker: Label = $NameTag/Speaker
@onready var message: RichTextLabel = $DialogBox/Message
@onready var timer: Timer = $DialogBox/Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var json_file : JSON
@export var scene := 0

var json
var displayed := false
var visible_char := 1

func _ready() -> void:
	json = json_file.data
	read()

func _process(delta: float) -> void:
	message.visible_characters = visible_char
	timer.wait_time = lerp(.1,.01,Globals.txt_spd)
	
	if Input.is_action_just_pressed("left_mouse"):
		print(displayed)
		if !displayed:
			visible_char = message.text.length()
			displayed = true
		else:
			if json.size() > scene + 1:
				scene += 1
				read()

func read() -> void:
	displayed = false
	visible_char = 1
	speaker.text = json[scene].speaker
	message.text = json[scene].message
	animation_player.play(str(scene))
	timer.start()


func _on_timer_timeout() -> void:
	visible_char += 1
	if message.text.length() > visible_char:
		timer.start()
	else:
		displayed = true
