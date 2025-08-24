extends Node

enum State {IDLE, WALK, JUMP_START, JUMP_END}

@export var SPEED : int = 70
@export var GRAVITY : int = 300

@export var JUMPFORCE : int = -180
@export var JUMP_HORIZONTAL : int = 100

var has_jumped : bool = false

func player_falling(delta : float, player: CharacterBody2D, velocity : Vector2):
	if !player.is_on_floor():
		player.velocity.y += GRAVITY * delta
		if player.velocity.y < 0:
			player.current_state = State.JUMP_START
		else:
			player.current_state = State.JUMP_END
	elif player.is_on_floor():
		has_jumped = false
		player.current_state = State.IDLE

# jump logic for the player
func player_jump(delta : float, player: CharacterBody2D, velocity : Vector2):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = JUMPFORCE
		player.current_state = State.JUMP_START
		has_jumped = true
	if !player.is_on_floor():
		if player.current_state == State.JUMP_START or player.current_state == State.JUMP_END:
			var direction = player.input_movement()
			if direction != 0 and !player.is_on_floor():
				player.animated_sprite_2d.flip_h = false if direction > 0 else true
				player.velocity.x += direction * JUMP_HORIZONTAL * delta

# function for when the player is idle (not doing anything : DEFAULT)
func player_idle(delta : float, player: CharacterBody2D):
	if player.is_on_floor() and player.current_state != State.JUMP_START and player.current_state != State.JUMP_END:
		player.current_state = State.IDLE

# Player running logic
func player_walk(delta : float, player: CharacterBody2D, velocity : Vector2):
	# Gets player direction depending on user input (created through project settings>input map)
	var direction = player.input_movement()
	# If player is running or not
	if direction:
		player.velocity.x = direction * SPEED # speed of the player horizontal movement
	else:
		player.velocity.x = move_toward(velocity.x, 0 ,SPEED) # gradually reduces speed when zero input
	# Sets Run State
	if direction != 0 and player.is_on_floor():
		player.current_state = State.WALK
		# if player goes left it flips sprite animation to indicate direction
		player.animated_sprite_2d.flip_h = false if direction > 0 else true
