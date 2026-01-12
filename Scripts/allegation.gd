extends Area2D

const TRUTH_NUKES = [
	"[outline_size=16]I think Kronii is not a [color=#FF6700][shake level=24]Cat[/shake][/color]",
	"[outline_size=16]I think Kronii is not a [color=#FF6700][shake level=24]Dog[/shake][/color]",
	"[outline_size=16]I think Kronii is not a [color=#FF6700][shake level=24]Furry[/shake][/color]",
	"[outline_size=16]Kronii definetly is [color=#FF6700][shake level=24]not into[/shake][/color] pet play",
	"[outline_size=16]I think Kronii makes very convincing [color=#FF6700][shake level=24]Cat Sounds[/shake][/color]",
	"[outline_size=16]Kronii's manager is a [color=#FF6700][shake level=24]Furry[/shake][/color], and thats very cool!",
	"[outline_size=16]Kronii definetly doesn't like [color=#FF6700][shake level=24]using Collars[/shake][/color]",
	"[outline_size=16]Kronii's cat noises are only for [color=#FF6700][shake level=24]Comedy[/shake][/color]",
]
const NOT_TRUTH_NUKES = [
	"[outline_size=16]I think Kronii is a [color=#FF6700][shake level=24]Cat[/shake][/color]",
	"[outline_size=16]I think Kronii is a [color=#FF6700][shake level=24]Dog[/shake][/color]",
	"[outline_size=16]I think Kronii is a [color=#FF6700][shake level=24]Furry[/shake][/color]",
	"[outline_size=16]Kronii definetly is [color=#FF6700][shake level=24]into[/shake][/color] pet play",
	"[outline_size=16]Kronii makes [color=#FF6700][shake level=24]Cat Sounds[/shake][/color] because she's into it",
	"[outline_size=16]Kronii's manager is a [color=#FF6700][shake level=24]Furry[/shake][/color], therefore she also is",
	"[outline_size=16]Kronii definetly likes [color=#FF6700][shake level=24]using Collars[/shake][/color]",
	"[outline_size=16]Kronii's cat noises aren't for [color=#FF6700][shake level=24]Comedy[/shake][/color]",
]

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: RichTextLabel = $RichTextLabel

@export var SPEED : float
var fake : bool
var allegation : String
var dir : int
var done : bool

signal clicked_allegation(is_fake : bool)
signal parry
signal mouse_hover(is_hovering : bool)

func _ready() -> void:
	if fake:
		allegation = NOT_TRUTH_NUKES.pick_random()
	else:
		allegation = TRUTH_NUKES.pick_random()
	label.text = allegation
	if Globals.gauntlet:
		SPEED = 3


func _process(delta: float) -> void:
	if !done:
		position.x += SPEED * dir


func shot() -> void:
	label.text = "[al shot=1]" + allegation


func _allegation_ended() -> void:
	done = true


func _parry() -> void:
	emit_signal("parry")


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_mouse") and !done:
		emit_signal("clicked_allegation",fake)
		if fake:
			animation_player.play("shot")
		else:
			animation_player.play("parry")


func _on_mouse_entered() -> void:
	emit_signal("mouse_hover", true)


func _on_mouse_exited() -> void:
	emit_signal("mouse_hover", false)
