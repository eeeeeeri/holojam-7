extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.animation_finished.connect(_on_animation_finished)
	
func _on_animation_finished(anim_name):
	if anim_name == "Close":
		on_transition_finished.emit()
		animation_player.play("Open")
	elif anim_name == "Open":
		color_rect.visible = false
	
func transition_scene(scene: String):
	color_rect.visible = true
	animation_player.play("Close")
	await on_transition_finished
	get_tree().change_scene_to_file(scene)
