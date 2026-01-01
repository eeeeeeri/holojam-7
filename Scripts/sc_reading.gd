extends Node2D

const SUPERCHAT = preload("uid://d16ukgas0boul")

var superchats = []
var sc_num = 0
var read = 0

func _ready() -> void:
	sc_num = randi_range(3,8)
	
	for i in range(sc_num):
		var new_superchat := SUPERCHAT.instantiate()
		new_superchat.position.y = (sc_num - i - 1) * -36
		add_child(new_superchat)
		superchats.append(new_superchat)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		read += 1
		if read >= sc_num:
			Globals.last_minigame_won = true
