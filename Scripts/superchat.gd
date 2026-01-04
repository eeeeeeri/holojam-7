extends Sprite2D

const usernames = [
	"@eeeeeeeeeeri",
	"@Perks",
	"@gogibahp",
	"@isaidmaybe",
	"@EatingMikeTysonsAss",
	"@KFP_Employee",
	"@Deadbeat",
	"@Takodachi",
	"@Teamate",
	"@Chumbuddy",
	"@Irystocrat",
	"@Brat",
	"@Kronie",
	"@Last_Kronie",
	"@Sapling",
	"@Hooman",
	"@Sanalite",
	"@Novelite",
	"@Pebble",
	"@Ruffian",
	"@Rosarian",
	"@Grem",
	"@Otomo",
	"@Chattini",
]

const messages = [
	"I miss holoen",
	"I love your streams Kronii!",
	"Otsu~!",
	"Have a great stream!",
	"Have my life savings",
	"I run out of ideas",
	"MY DOG JUST DIED LETSGOOOOOOOO!!!",
	"Will you marry me?",
	"PLEASE DON'T GRADUATE",
	"I will miss you Kronii"
]

@onready var username: Label = $Username
@onready var message: Label = $Message
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	frame = randi_range(0,4)
	username.text = usernames.pick_random()
	message.text = messages.pick_random()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		animation_player.play("jump")
		position.y += 36
