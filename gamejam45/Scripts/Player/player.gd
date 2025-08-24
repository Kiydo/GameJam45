extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_effect: AudioStreamPlayer = $AudioManager/jump
@onready var movement = preload("res://Scripts/Player/player_movement.gd").new()

enum State {IDLE, WALK, JUMP_START, JUMP_END}
enum Player_direction {RIGHT, LEFT}

var current_state: State = State.IDLE
var current_player_direction
var animation_trigger := false

func _ready():
	if animated_sprite_2d.is_connected("animation_finished", Callable(self, "_on_animation_finished")) == false:
		animated_sprite_2d.connect("animation_finished", Callable(self, "_on_animation_finished"))

func set_state(new_state: State) -> void:
	if current_state == new_state:
		return
	current_state = new_state
	animation_trigger = false

func _physics_process(delta: float) -> void:
	player_face_direction()
	movement.player_falling(delta, self, velocity)
	movement.player_idle(delta, self)
	movement.player_walk(delta, self, velocity)
	movement.player_jump(delta, self, velocity)
	move_and_slide()
	player_animations()

func input_movement():
	return Input.get_axis("move_left", "move_right")

func player_face_direction():
	var direction = input_movement()
	if direction > 0:
		current_player_direction = Player_direction.RIGHT
	elif direction < 0:
		current_player_direction = Player_direction.LEFT

func player_animations():
	match current_state:
		State.IDLE:
			if not animation_trigger:
				animated_sprite_2d.play("idle")
				animation_trigger = true
		State.WALK:
			if not animation_trigger:
				animated_sprite_2d.play("walk")
				animation_trigger = true
		State.JUMP_START:
			if not animation_trigger:
				animated_sprite_2d.play("jump_start")
				animation_trigger = true
		State.JUMP_END:
			if not animation_trigger:
				animated_sprite_2d.play("jump_end")
				animation_trigger = true
