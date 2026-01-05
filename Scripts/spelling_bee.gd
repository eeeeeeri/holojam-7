extends Node2D

@onready var word_label: Label = $Word
@onready var anwser: Label = $Anwser
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var confetti: CPUParticles2D = $Confetti
@onready var minigame: Minigame = $".."
@onready var puppet_kronii: AnimatedSprite2D = $PuppetKronii

const words = [
	"SUPERCALIFRAGILISTICEXPIALIDOCIOUS",
	"CODEPENDENCY",
	"FETTUCCINE",
	"DECAFFEINATED",
	"BROCHURE",
	"ELLIPTICAL",
	"REFRIGERATOR",
	"CONNOISSEUR",
	"PTERODACTYL",
	"SILHOUETTE",
	"DOPPELGANGER",
	"ARCHIPELAGO",
	"ACACIA",
	"DISCOMBOBULATE",
	"HEMORRHOID",
	"AQUEDUCT",
	"AFFIDAVIT",
	"GWAKKKKKKKKKK",
]

var word := ""
var typed := ""
var missed := false

func _ready() -> void:
	word = words.pick_random()
	word_label.text = word

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.is_pressed():
		var ch = event.as_text_keycode()
		if ch.length() == 1 and !Globals.last_minigame_won:
			typed += ch
			anwser.text = typed
			puppet_kronii.play("talk")
			if !word.begins_with(typed) and !missed:
				animation_player.play("miss")
				minigame.done = true
				missed = true
			if word == typed:
				Globals.last_minigame_won = true
				minigame.done = true
				anwser.modulate = Color.GREEN
				confetti.emitting = true
