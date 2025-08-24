extends Node2D

func _on_button_pressed() -> void:
	var default_scene = "res://Scene/UI/menu.tscn"
	print("loading about")
	call_deferred("change_scene", default_scene)

func change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)
