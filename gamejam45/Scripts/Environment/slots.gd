extends AnimatedSprite2D
#@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var coin_flip : float = 0.5

enum State {SUCCESS, FAIL}
var current_state : State
var button_pressed : bool = false
var next_level_number

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anims = get_sprite_frames().get_animation_names()
	print("Available animations: ", anims)
	connect("animation_finished", Callable(self, "_on_animation_finished"))
	randomize()

func recive_roll(result):
	print("putting in roll")
	while button_pressed == false:
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
	next_level()
	button_pressed = true
	
func next_level():
	print("going to next level")
	var current_scene_file = get_tree().current_scene.scene_file_path
	print("current level path: ", current_scene_file)
	if current_state == State.SUCCESS:
		next_level_number = current_scene_file.to_int() + 1
		print(next_level_number)
	else:
		next_level_number = current_scene_file.to_int() - 1
		print(next_level_number)
	await get_tree().create_timer(4.0).timeout
	var next_level_path = "res://Scene/Stages/stage" + str(next_level_number) + ".tscn"
	call_deferred("change_scene", next_level_path)

func change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)
