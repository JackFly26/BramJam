extends KinematicBody2D

var velocity = Vector2()
export var left = true
export var acceleration = .2
export var max_speed = 200
export var friction = .1
export var gravity = 20
export var jump_power = -500

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _physics_process(_delta):
	var prefix
	if left:
		prefix = "left_"
	else:
		prefix = "right_"
	var input = (Input.get_action_strength(prefix + "right") - Input.get_action_strength(prefix + "left"))
	if input != 0:
		velocity.x = lerp(velocity.x, input * max_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	if Input.is_action_just_pressed(prefix + "up") and is_on_floor():
		velocity.y = jump_power
	else:
		velocity.y += gravity
	print(is_on_floor())
	velocity = move_and_slide(velocity, Vector2.UP)
