@tool
extends RichTextEffect
class_name AllegationEffect

var bbcode = "al"
const offsets = [Vector2(0.499873, 0.636194), Vector2(-0.426504, 0.679601), Vector2(0.583974, 0.217037), Vector2(0.001973, -0.298844), Vector2(0.531681, -0.274061), Vector2(-0.955093, 0.371558), Vector2(0.597942, 0.560324), Vector2(-0.75609, -0.327532), Vector2(0.906292, 0.710159), Vector2(0.888108, 0.627916), Vector2(0.768823, 0.664223), Vector2(0.480191, -0.50625), Vector2(0.699026, 0.703247), Vector2(-0.891942, 0.901622), Vector2(0.061842, -0.033151), Vector2(-0.151771, -0.549124), Vector2(0.020773, -0.884744), Vector2(0.393252, -0.349724), Vector2(0.292889, -0.448596), Vector2(-0.101895, 0.204746), Vector2(0.136476, 0.033736), Vector2(0.940772, 0.772473), Vector2(0.961553, -0.783165), Vector2(-0.829088, -0.286365), Vector2(-0.980596, 0.433747), Vector2(-0.154, 0.663013), Vector2(0.764407, -0.551248), Vector2(-0.50522, 0.158288), Vector2(-0.910742, 0.790564), Vector2(-0.420243, 0.830603), Vector2(0.655704, 0.852212), Vector2(0.838946, 0.690239), Vector2(-0.755645, -0.587883), Vector2(-0.811269, 0.00149), Vector2(-0.755862, -0.39259), Vector2(0.961398, -0.242796), Vector2(0.677449, 0.155812), Vector2(0.086807, 0.520697), Vector2(-0.308195, 0.429103), Vector2(0.210457, -0.799919), Vector2(0.261992, -0.492111), Vector2(-0.344495, -0.753068), Vector2(-0.118245, -0.493312), Vector2(0.864022, 0.963271), Vector2(0.743536, -0.874233), Vector2(0.433498, -0.102644), Vector2(-0.488566, -0.256963), Vector2(-0.742805, -0.288596), Vector2(0.219577, 0.117522), Vector2(0.065203, -0.28399)]
var time_past: float

func _process_custom_fx(char_fx: CharFXTransform):
	#var shot = char_fx.env.get("shot",0)
	#if shot == 1:
		#time_past = char_fx.elapsed_time
	char_fx.offset = offsets[char_fx.relative_index] * (char_fx.elapsed_time - time_past) * 1000
