extends Control

@onready var music_slider: HSlider = $VBoxContainer/VBoxContainer/MusicSlider
@onready var sfx_slider: HSlider = $VBoxContainer/VBoxContainer2/SfxSlider


func _ready() -> void:
	resume()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume()
		else:
			pause()
	

func resume():
	visible = false
	get_tree().paused = false

func pause():
	visible = true
	get_tree().paused = true


func _on_pause_button_button_up() -> void:
	resume()


func _on_quit_button_button_down() -> void:
	get_tree().quit()
