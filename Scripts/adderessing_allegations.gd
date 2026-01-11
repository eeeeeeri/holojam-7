extends Node2D

@onready var spawn: Timer = $Spawn
@onready var reticle: Sprite2D = $Reticle
@onready var minigame: Minigame = $".."
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const ALLEGATION = preload("uid://00u6xa14w4p")

var allegations_number = 5
var allegations = []
var allegations_count = 0
var mouse_hovering := false

signal allegation_ended

func _ready() -> void:
	var fake = randi_range(1,allegations_number-1)
	
	for i in range(allegations_number):
		var allegation = ALLEGATION.instantiate()
		var dir = (randi() & 2) - 1
		var _x = -150 if dir > 0 else 256+150
		var _y = randf_range(32, 96)
		allegation.fake = i == fake
		allegation.dir = dir
		allegation.position = Vector2(_x,_y)
		allegation.clicked_allegation.connect(_clicked_allegation)
		allegation.mouse_hover.connect(_mouse_hover)
		allegation.parry.connect(_parry)
		allegation_ended.connect(allegation._allegation_ended)
		allegations.append(allegation)
	
	spawn_allegation()

func _process(delta: float) -> void:
	reticle.position = get_local_mouse_position()
	if mouse_hovering:
		reticle.frame = 1
		reticle.rotation = 0
	else:
		reticle.frame = 0
		reticle.rotate(.1)

func _clicked_allegation(is_fake: bool) -> void:
	emit_signal("allegation_ended")
	if is_fake:
		animation_player.play("shot")
		Globals.last_minigame_won = true

func _parry() -> void:
	animation_player.play("parry")

func _mouse_hover(is_hovered : bool) -> void:
	mouse_hovering = is_hovered

func spawn_allegation() -> void:
	if allegations_number > allegations_count:
		add_child(allegations[allegations_count])
		allegations_count += 1

func done():
	minigame.done = true

func _on_spawn_timeout() -> void:
	if !minigame.done:
		spawn_allegation()
