extends Node2D

const SUPERCHAT = preload("uid://d16ukgas0boul")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var minigame: Minigame = $".."

var superchats = []
var sc_num := 0
var read := 0
var won := false

func _ready() -> void:
	sc_num = randi_range(3,8)
	
	for i in range(sc_num):
		var new_superchat := SUPERCHAT.instantiate()
		new_superchat.position.y = (sc_num - i - 1) * -36
		add_child(new_superchat)
		superchats.append(new_superchat)

func _process(delta: float) -> void:
	if !won:
		if Input.is_action_just_pressed("left_mouse"):
			read += 1
			animation_player.play("sc_ty")
			if read >= sc_num:
				animation_player.play("appear")
				
				Globals.last_minigame_won = true
				minigame.done = true
				won = true
