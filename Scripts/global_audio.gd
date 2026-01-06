extends AudioStreamPlayer

@onready var st = stream as AudioStreamSynchronized
@onready var trans_timer: Timer = $TransTimer

enum Melody {NONE, LOUD_NO_VOX, LOUD_VOX, QUIET_SPACE, QUIET}
enum Drums {NONE, FAST, SLOW}

var melody_playing : Melody
var drums_playing : Drums
var last_melody : Melody
var last_drums : Drums
var in_vol : float
var out_vol : float

const ZERO_VOL := -60.0
const MAX_VOL := 0.0

func _process(delta: float) -> void:
	# Smooth Transition
	#var r = inverse_lerp(0, trans_timer.wait_time, trans_timer.wait_time - trans_timer.time_left)
	#in_vol = min(ZERO_VOL + r * (-ZERO_VOL), 0.0)
	#out_vol = min(ZERO_VOL + (1.0 - r) * (-ZERO_VOL), 0.0)
	
	# Not Smooth
	in_vol = MAX_VOL
	out_vol = ZERO_VOL
	
	match last_melody:
		Melody.LOUD_NO_VOX:
			stream.set_sync_stream_volume(0, out_vol)
		Melody.LOUD_VOX:
			stream.set_sync_stream_volume(1, out_vol)
		Melody.QUIET_SPACE:
			stream.set_sync_stream_volume(2, out_vol)
		Melody.QUIET:
			stream.set_sync_stream_volume(3, out_vol)
	
	match last_drums:
		Drums.FAST:
			stream.set_sync_stream_volume(4, out_vol)
		Drums.SLOW:
			stream.set_sync_stream_volume(5, out_vol)
	
	match melody_playing:
		Melody.LOUD_NO_VOX:
			stream.set_sync_stream_volume(0, in_vol)
		Melody.LOUD_VOX:
			stream.set_sync_stream_volume(1, in_vol)
		Melody.QUIET_SPACE:
			stream.set_sync_stream_volume(2, in_vol)
		Melody.QUIET:
			stream.set_sync_stream_volume(3, in_vol)
	
	match drums_playing:
		Drums.FAST:
			stream.set_sync_stream_volume(4, in_vol)
		Drums.SLOW:
			stream.set_sync_stream_volume(5, in_vol)

func play_tracks(melody: Melody, drums: Drums):
	last_melody = melody_playing
	last_drums = drums_playing
	melody_playing = melody
	drums_playing = drums
	trans_timer.start()
