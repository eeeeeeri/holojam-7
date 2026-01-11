extends Sprite2D

@export var weekday : Globals.WeekDay
var minigame : Minigame
var today : bool
var offline : bool

@onready var label: Label = $Label
@onready var title: Label = $Title
@onready var description: Label = $Description
var finished = false

func _ready() -> void:
	
	match weekday:
		Globals.WeekDay.MON:
			label.text = "MON"
		Globals.WeekDay.TUE:
			label.text = "TUE"
		Globals.WeekDay.WED:
			label.text = "WED"
		Globals.WeekDay.THU:
			label.text = "THU"
		Globals.WeekDay.FRI:
			label.text = "FRI"
		Globals.WeekDay.SAT:
			label.text = "SAT"
		Globals.WeekDay.SUN:
			label.text = "SUN"


func _process(delta: float) -> void:
	
	if weekday == Globals.today:
		frame = 1
	
	if offline:
		frame = 2
		title.visible = false
		description.visible = false
	
	if minigame:
		title.text = minigame.title
		description.text = minigame.description
	else:
		title.text = "???"
		description.text = "???"
	
	if finished:
		title.text = "GRADUATION STREAM"
		description.text = "it's finally here."
		frame = 3
