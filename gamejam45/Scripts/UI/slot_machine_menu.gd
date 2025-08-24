extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anims = get_sprite_frames().get_animation_names()
	print("Available animations: ", anims)
	connect("animation_finished", Callable(self, "_on_animation_finished"))

func play_selected():
	print("selected play")
	play("play")
	await get_tree().create_timer(1.0).timeout
	var default_scene = "res://Scene/Stages/stage0.tscn"
	print("loading stage?")
	call_deferred("change_scene", default_scene)

func change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
