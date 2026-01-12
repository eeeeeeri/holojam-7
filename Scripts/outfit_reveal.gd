extends Node2D

@onready var outfit: Sprite2D = $Outfit
@onready var minigame: Minigame = $".."
@onready var confetti: CPUParticles2D = $Confetti
@onready var end_timer: Timer = $"../EndTimer"
var start_pos : Vector2
var outfit_pos : Vector2
var swiping : bool
var speed := .05
var done := false

func _ready() -> void:
	if Globals.gauntlet:
		end_timer.wait_time = 1.5

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("left_mouse") and !minigame.done and !done:
		swiping = true
		start_pos = get_global_mouse_position()
		outfit_pos = outfit.position
	if Input.is_action_just_released("left_mouse"):
		swiping = false
	
	if swiping:
		var distance = start_pos.y - get_global_mouse_position().y
		outfit.position.y = outfit_pos.y - distance
		outfit.position.y = clamp(outfit.position.y,-144,288)
	
	if outfit.position.y >= 288 and !done:
		outfit.frame = 1
		swiping = false
		confetti.emitting = true
		minigame.done = true
		Globals.last_minigame_won = true
		done = true
		
