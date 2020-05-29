extends KinematicBody2D

var velocity = Vector2()
export var left = true
export var acceleration = 2
export var max_speed = 5
export var friction = .1
export var gravity = 5
export var jump_power = -10

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _physics_process(delta):
	velocity.y += gravity * delta
	var prefix
	if left:
		prefix = "left_"
	else:
		prefix = "right_"
	velocity.x += (Input.get_action_strength(prefix + "right") - Input.get_action_strength(prefix + "left")) * acceleration
	velocity.x = lerp(velocity.x, 0, friction)
	velocity = velocity.clamped(max_speed)
	if Input.is_action_just_pressed(prefix + "up"): #and is_on_floor():
		velocity.y = jump_power
	move_and_collide(velocity)
