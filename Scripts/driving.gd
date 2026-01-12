extends Node2D

@onready var road: Polygon2D = $Road
@onready var line: Line2D = $Line
@onready var left_line: Line2D = $LeftLine
@onready var right_line: Line2D = $RightLine
@onready var obstacles: Node2D = $Obstacles
@onready var tree_spawner: Timer = $TreeSpawner
@onready var obstacle_spawner: Timer = $ObstacleSpawner
@onready var minigame: Minigame = $".."
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var crash_timer: Timer = $CrashTimer
@onready var explosion_sound: AudioStreamPlayer = $ExplosionSound

const TREE = preload("uid://ib0q14jmhhhq")
const ROCK = preload("uid://ce2brbiebltmd")

@export var speed := 8.0
@export var width := 256.0
var started = false

signal crash

func _ready() -> void:
	Globals.cam_x = 128.0

func _process(delta: float) -> void:
	if !started:
		Globals.last_minigame_won = true
	
	if Input.is_action_pressed("left_key"):
		Globals.cam_x += speed
	if Input.is_action_pressed("right_key"):
		Globals.cam_x -= speed
	
	Globals.cam_x = clamp(Globals.cam_x, -(width/2), width*1.5)
	
	road.polygon[1].x = Globals.cam_x + width
	road.polygon[2].x = Globals.cam_x - width
	
	line.points[1].x = Globals.cam_x
	left_line.points[1].x = Globals.cam_x - width + 32
	right_line.points[1].x = Globals.cam_x + width - 32


func spawn_tree(_x : float) -> void:
	var tree = TREE.instantiate()
	tree._x = _x
	tree.scale = Vector2.ZERO
	tree.position.y = 65
	crash.connect(tree._crash)
	obstacles.add_child(tree)

func spawn_obstacle(_x : float) -> void:
	var obstacle = ROCK.instantiate()
	obstacle._x = _x
	obstacle.scale = Vector2.ZERO
	obstacle.position.y = 65
	crash.connect(obstacle._crash)
	obstacles.add_child(obstacle)


func _on_tree_spawner_timeout() -> void:
	spawn_tree(-256)
	spawn_tree(512)


func _on_obstacle_spawner_timeout() -> void:
	var _x = randf_range(0,256)
	spawn_obstacle(_x)


func _on_car_body_entered(body: Node2D) -> void:
	explosion_sound.play()
	crash_timer.start()

func _on_crash_timer_timeout() -> void:
	emit_signal("crash")
	animation_player.play("KroniiDies")
	tree_spawner.stop()
	obstacle_spawner.stop()
	Globals.last_minigame_won = false
	minigame.done = true
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),true)
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"),true)
