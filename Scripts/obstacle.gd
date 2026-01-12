extends CharacterBody2D

@export var speed := 4.0
@export var car_speed := 8.0
@export var limit := 144.0
@export var _x : float

func _ready() -> void:
	if Globals.gauntlet:
		speed = 6

func _process(delta: float) -> void:
	
	var distance = inverse_lerp(64, 144, position.y)
	scale = Vector2(distance,distance) * 5
	
	position.y += distance * speed
	position.x = 128 - ((_x - Globals.cam_x) * distance)
	
	if global_position.y > limit: queue_free()

func _crash() -> void:
	speed = 0
