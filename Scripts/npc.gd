class_name NPC extends AnimatedSprite2D

func _yap(emotion : String) -> void:
	play(emotion)

func _shut_up() -> void:
	stop()
