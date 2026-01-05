extends AudioStreamPlayer

const main_theme = preload("res://Assets/Music/souten ni moyu loop.wav")

func _play_music(music: AudioStream, volume = -5.0):
	if stream == music:
		return
	stream = music
	
	volume_db = volume
	play()

func play_music():
	_play_music(main_theme)
