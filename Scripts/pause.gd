extends Control

@onready var speed_slider: HSlider = $VBoxContainer/VBoxContainer4/SpeedSlider

func _ready() -> void:
	var audio_settings = ConfigFileHandler.load_audio_settings()
	speed_slider.value = audio_settings["TextSpeed"]
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


func _on_speed_slider_value_changed(value: float) -> void:
	Globals.txt_spd = value


func _on_speed_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigFileHandler.save_audio_setting("TextSpeed", Globals.txt_spd)
