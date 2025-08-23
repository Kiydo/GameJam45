extends CharacterBody2D
@export var character_body_2d : CharacterBody2D = null

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


enum State {NOT_PRESSED, PRESSED}
var animation_trigger : bool = false
var fail_trigger : bool = false

func _ready() -> void:
	animated_sprite_2d.connect("animation_finished", Callable(self, "_on_animation_finished"))
	character_body_2d = get_parent().get_node("Player")


func _on_hurtbox_body_entered(body: Node2D) -> void:
	print("pressed green button")
	animated_sprite_2d.play("pressed")
	fail_trigger = true
