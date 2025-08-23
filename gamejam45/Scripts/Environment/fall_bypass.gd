extends Area2D

@export var character_body_2d : CharacterBody2D = null
@onready var slots = get_parent().get_node("Slots")

enum State {NOT_PRESSED, PRESSED}
var current_state: State
var result
var animation_trigger : bool = false
var fail_trigger : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	character_body_2d = get_parent().get_node("Player")


func _on_body_entered(body: Node2D) -> void:
	fail_trigger = true
	print("Roll Failed")
	result = false
	slots.recive_roll(result)
