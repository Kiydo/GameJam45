extends CharacterBody2D


@export var character_body_2d : CharacterBody2D = null
@export var success_chance : float = 0.8

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#@onready var slots = preload("res://Prefab/Environment/slots.gd").new
@onready var slots = get_parent().get_node("Slots")


enum State {IDLE, SUCCESS, FAIL}
var current_state: State = State.IDLE
var animation_trigger : bool = false
var fail_trigger : bool = false
var result : bool = false # false = fail

func _ready() -> void:
	animated_sprite_2d.connect("animation_finished", Callable(self, "_on_animation_finished"))
	character_body_2d = get_parent().get_node("Player")
	randomize()# for randf()

func _gamble() -> void:
	var roll = randf() # roll for the odds
	if roll <= success_chance:
		print("Roll Success")
		result = true
	else:
		print("Roll Failed")
		result = false
	slots.recive_roll(result)


func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("pressed green button")
	animated_sprite_2d.play("pressed")
	_gamble()
	fail_trigger = true
