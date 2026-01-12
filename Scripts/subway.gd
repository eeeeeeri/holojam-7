extends Node2D

@onready var subway: Sprite2D = $Subway
@onready var kronii: Sprite2D = $Kronii
@onready var hand: Sprite2D = $Hand
@onready var minigame: Minigame = $".."
@onready var confetti: CPUParticles2D = $Confetti
@onready var end_timer: Timer = $"../EndTimer"

var start_pos : Vector2
var subway_pos : Vector2
var swiping : bool
var speed := .05
var done := false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if Globals.gauntlet:
		end_timer.wait_time = 1.5

func _process(delta: float) -> void:
	hand.position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("left_mouse") and !minigame.done:
		swiping = true
		start_pos = get_global_mouse_position()
		subway_pos = subway.position
	if Input.is_action_just_released("left_mouse"):
		swiping = false
	
	if swiping:
		var distance = start_pos.x - get_global_mouse_position().x
		subway.position.x = subway_pos.x - distance
		subway.position.x = clamp(subway.position.x, -300, 384)
	
	if subway.position.x <= -300 and !done:
		kronii.frame = 1
		swiping = false
		confetti.emitting = true
		minigame.done = true
		Globals.last_minigame_won = true
		done = true
