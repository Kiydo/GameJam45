extends AnimatedSprite2D
var current_scene_file

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anims = get_sprite_frames().get_animation_names()
	print("Available animations: ", anims)
	connect("animation_finished", Callable(self, "_on_animation_finished"))
	
	#var current_scene_file = get_tree().current_scene.scene_file_path
	#var file_name = current_scene_file.get_file()
	#print(current_scene_file)
	#print("file name: ", file_name)
	#expression_animation(file_name)

func expression_animation(file_name):
	if file_name == "stage0.tscn":
		play("neutral")
	elif file_name == "stage1.tscn":
		play("+1up")
	elif file_name == "stage2.tscn":
		play("+2up")
	elif file_name == "stage-1.tscn":
		play("-1down")
	elif file_name == "stage-2.tscn":
		play("-2down")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_scene_file = get_tree().current_scene.scene_file_path
	var file_name = current_scene_file.get_file()
	expression_animation(file_name)
