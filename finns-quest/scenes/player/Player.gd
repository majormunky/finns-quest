extends CharacterBody2D

var speed = 200
var current_direction = "down"
var is_moving = false
@onready var animation_player = $AnimationPlayer
@onready var interact_box = $Detection/InteractBox/CollisionShape2D

func _physics_process(delta: float) -> void:
	# check to see if we are hitting the interact button
	if Input.is_action_just_pressed("Inspect"):
		interact_box.disabled = false
		await get_tree().create_timer(0.05).timeout
		interact_box.disabled = true
		return
	
	# figure out what direction the player is wanting to go
	var input = Vector2.ZERO
	
	input.x = Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft")
	input.y = Input.get_action_strength("WalkDown") - Input.get_action_strength("WalkUp")
	input = input.normalized()
	
	# deal with either idling, or walking
	if input != Vector2.ZERO:
		# walking
		is_moving = true
		current_direction = get_player_direction(input)
		
		# ensure we're moving in a frame rate independent way
		velocity = input * speed * delta
	else:
		# idling
		velocity = Vector2.ZERO
		is_moving = false
	
	# update the animation
	update_animation()
	
	# and finally move the player on the screen
	move_and_collide(velocity)


func update_animation():
	# This function checks the current direction and if we're moving
	# and then plays the animation that matches
	var animation_name = ""
	if is_moving:
		animation_name = "walk_" + current_direction
	else:
		animation_name = "idle_" + current_direction
	animation_player.play(animation_name)

func get_player_direction(input_vector):
	# here we're just seeing what direction our input is and
	# returning a string that tells us what direction to go
	# may not work for diagnal, will revisit later
	if input_vector.x > 0:
		return "right"
	elif input_vector.x < 0:
		return "left"
	elif input_vector.y > 0:
		return "down"
	elif input_vector.y < 0:
		return "up"


func _on_interact_box_area_entered(area: Area2D) -> void:
	print("Area Entered:" + area.name)
