extends CharacterBody2D

# ANIMATION NODES
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D/AnimatedSprite2D2

@onready var movement = preload("res://Scripts/Player/player_movement.gd").new()

# STATES
enum State {IDLE, WALK, JUMP_START, JUMP_END}
enum Player_direction {RIGHT, LEFT}
var current_state: State

var animation_trigger = false
var animation_trigger2 = false
var character_sprite : Sprite2D
var current_player_direction

#
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

func _ready():
	current_state = State.IDLE
	animated_sprite_2d.connect("animation_finished", Callable(self, "_on_animation_finished"))


func _physics_process(delta: float):
	player_face_direction()
	movement.player_falling(delta, self, velocity)
	movement.player_idle(delta, self)
	movement.player_walk(delta, self, velocity)
	movement.player_jump(delta, self, velocity)
	move_and_slide()
	player_animations()

func input_movement():
	var direction : float = Input.get_axis("move_left", "move_right")
	return direction

func player_face_direction():
	var direction = input_movement()
	if direction > 0:
		current_player_direction = Player_direction.RIGHT
	elif direction < 0:
		current_player_direction = Player_direction.LEFT
		
func player_animations():
	match current_state:
		State.IDLE:
			if animation_trigger == false:
				animated_sprite_2d.play("idle")
		State.WALK:
			if animation_trigger == false:
				animated_sprite_2d.play("walk")
		State.JUMP_START:
			if animation_trigger == false:
				animated_sprite_2d.play("jump_start")
		State.JUMP_END:
			if animation_trigger == false:
				animated_sprite_2d.play("jump_end")


func _on_animation_finished():
	animation_trigger = false
func _on_animation_finished2():
	animation_trigger2 = false
