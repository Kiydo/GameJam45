extends AnimatedSprite2D
#@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var coin_flip : float = 0.5

enum State {SUCCESS, FAIL}
var current_state : State
var animation_trigger : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anims = get_sprite_frames().get_animation_names()
	print("Available animations: ", anims)
	connect("animation_finished", Callable(self, "_on_animation_finished"))
	randomize()

func recive_roll(result):
	print("putting in roll")
	if result == true:
		print("in")
		current_state = State.SUCCESS
	else:
		current_state = State.FAIL
	slot_animation()

func slot_animation():
	if current_state == State.SUCCESS:
		print("playing success animation")
		play("win")
	else:
		var roll = randf()
		if roll <= coin_flip:
			print("playing failed animation 1")
			play("failOne")
		else:
			print("playing failed animation 2")
			play("failTwo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
