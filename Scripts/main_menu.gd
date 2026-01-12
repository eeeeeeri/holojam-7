extends Control

@onready var main_screen: Control = $MainScreen
@onready var settings_screen: Control = $SettingsScreen
@onready var credits_screen: Control = $CreditsScreen
@onready var kronii: Sprite2D = $KroniiGradNeutral

func _ready() -> void:
	Music.play_tracks(Music.Melody.QUIET, Music.Drums.SLOW)
	if Globals.game_ended:
		kronii.visible=false


func _on_start_button_button_down() -> void:
	CutoutTransition.transition_scene("res://Scenes/Schedule/main.tscn")


func _on_settings_button_button_down() -> void:
	main_screen.visible = false
	settings_screen.visible = true


func _on_quit_button_button_down() -> void:
	get_tree().quit()


func _on_return_button_button_down() -> void:
	main_screen.visible = true
	settings_screen.visible = false
	credits_screen.visible = false


func _on_credits_button_button_down() -> void:
	main_screen.visible = false
	credits_screen.visible = true
