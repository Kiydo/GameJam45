extends Node2D
#@onready var slot_machine = get_parent().get_node("SlotMachineMenu")
@onready var slot_machine: Node = $SlotMachineMenu
@onready var lever_clank: AudioStreamPlayer = $AudioManager/clank

# Play Button
func _on_play_pressed() -> void:
	print("play button just pressed")
	slot_machine.play_selected()
	lever_clank.play()

# About
func _on_about_pressed() -> void:
	var default_scene = "res://Scene/UI/about.tscn"
	print("loading about")
	call_deferred("change_scene", default_scene)

func change_scene(next_level_path: String) -> void:
	get_tree().change_scene_to_file(next_level_path)

# Quit Game
func _on_quit_pressed() -> void:
	get_tree().quit()
