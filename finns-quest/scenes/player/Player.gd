extends CharacterBody2D

var speed = 200
var current_direction = "down"
var is_moving = false
@onready var animation_player = $AnimationPlayer

func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO
	
	input.x = Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft")
	input.y = Input.get_action_strength("WalkDown") - Input.get_action_strength("WalkUp")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		is_moving = true
		current_direction = get_player_direction(input)
		velocity = input * speed * delta
	else:
		velocity = Vector2.ZERO
		is_moving = false
	
	update_animation()
	move_and_collide(velocity)

func update_animation():
	var animation_name = ""
	if is_moving:
		animation_name = "walk_" + current_direction
	else:
		animation_name = "idle_" + current_direction
	animation_player.play(animation_name)

func get_player_direction(input_vector):
	if input_vector.x > 0:
		return "right"
	elif input_vector.x < 0:
		return "left"
	elif input_vector.y > 0:
		return "down"
	elif input_vector.y < 0:
		return "up"
