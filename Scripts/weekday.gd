extends PanelContainer

@export var weekday : Globals.WeekDay
var minigame : Minigame

@onready var label: Label = $HBoxContainer/Label
@onready var title: Label = $HBoxContainer/Minigame/Title
@onready var description: Label = $HBoxContainer/Minigame/Description

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
	
	if minigame:
		title.text = minigame.title
		description.text = minigame.description
	else:
		title.text = "???"
		description.text = "???"
