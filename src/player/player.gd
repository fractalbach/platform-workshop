extends KinematicBody2D

const GRAVITY = 200.0
const MAX_FALL_VELOCITY = GRAVITY
const RUN_SPEED = 100.0
const JUMP_SPEED = 150.0
var vel = Vector2()

const MAX_Y_POSITION = 500
const RESPAWN_LOCATION = Vector2(0, -50)

onready var sprite = $AnimatedSprite

func get_input():
	vel.x = 0
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")

	if is_on_floor() and up:
		vel.y = -JUMP_SPEED
		print("hi")
	if right:
		vel.x = RUN_SPEED
	if left:
		vel.x = -RUN_SPEED


func _physics_process(delta):
	handle_respawn()
	vel.y += GRAVITY * delta
	get_input()
	# vel = move_and_slide(vel, Vector2.UP)
	move_and_slide(vel, Vector2.UP)
	update_animations()
	


func update_animations():
	if is_on_floor():
		if abs(vel.x) > 0:
			sprite.play("run")
		else:
			sprite.play("default")
	else:
		sprite.play("jump")
	
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false


func handle_respawn():
	if position.y > MAX_Y_POSITION:
		position = RESPAWN_LOCATION
		vel.y = 0
