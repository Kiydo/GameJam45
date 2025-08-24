extends AudioStreamPlayer

const main_music = preload("res://Audio/mainmenu.mp3")

func _play_music(music: AudioStream, volume = 0.2):
	var current_scene_id = get_tree().current_scene
	var current_scene = current_scene_id.scene_file_path
	print(current_scene)
	if current_scene == "res://Scene/Stages/stage3.tscn" or current_scene == "res://Scene/Stages/stageDone.tscn" or current_scene == "res://Scene/Stages/stage-3.tscn":
		print("music should stop")
		stop()
		current_scene = ""
		return
	else:
		play()
		
	if stream == music:
		return
	stream = music
	volume_db = volume
	play()

func play_music():
	_play_music(main_music)
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
