extends Node

enum State {IDLE, WALK, JUMP_START, JUMP_END}

@export var SPEED : int = 70
@export var GRAVITY : int = 300
@export var JUMPFORCE : int = -180
@export var JUMP_HORIZONTAL : int = 100

var has_jumped : bool = false

func player_falling(delta : float, player: CharacterBody2D, velocity : Vector2):
	if not player.is_on_floor():
		player.velocity.y += GRAVITY * delta
		if player.velocity.y < 0:
			player.set_state(State.JUMP_START)
		else:
			player.set_state(State.JUMP_END)
	else:
		has_jumped = false
		player.set_state(State.IDLE)

func player_jump(delta : float, player: CharacterBody2D, velocity : Vector2):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = JUMPFORCE
		player.set_state(State.JUMP_START)
		player.jump_effect.play()
		has_jumped = true

	if not player.is_on_floor():
		if player.current_state == State.JUMP_START or player.current_state == State.JUMP_END:
			var direction = player.input_movement()
			if direction != 0:
				player.animated_sprite_2d.flip_h = direction < 0
				player.velocity.x += direction * JUMP_HORIZONTAL * delta

func player_idle(delta : float, player: CharacterBody2D):
	if player.is_on_floor() and player.current_state != State.JUMP_START and player.current_state != State.JUMP_END:
		player.set_state(State.IDLE)

func player_walk(delta : float, player: CharacterBody2D, velocity : Vector2):
	var direction = player.input_movement()
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(velocity.x, 0 ,SPEED)

	if direction != 0 and player.is_on_floor():
		player.set_state(State.WALK)
		player.animated_sprite_2d.flip_h = direction < 0
