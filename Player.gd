extends KinematicBody2D

var velocity = Vector2()
export var left = true
const acceleration = 512
const max_speed = 64
const friction = .02
const ground_friction = .1
const gravity = 512
const jump_power = -256


func _physics_process(delta):
	var prefix
	if left:
		prefix = "left_"
	else:
		prefix = "right_"
	var input = (Input.get_action_strength(prefix + "right") - Input.get_action_strength(prefix + "left"))
	if input != 0:
		velocity.x += clamp(input * acceleration * delta, -max_speed, max_speed)
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0, ground_friction)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	if Input.is_action_just_pressed(prefix + "up") and is_on_floor():
		velocity.y = jump_power
	else:
		velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
