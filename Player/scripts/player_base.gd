class_name PlayerBase extends CharacterBody2D

@export var acceleration_curve : Curve
@export var player_speed : float
@export var coyote_strafe_time : Timer
@export var max_jump_height: float
@export var player_gravity: float = 9.8
var direction: Vector2
var previous_direction : Vector2

var is_intent_to_move: bool = true


var is_jumped := false

var player_movement_hold_timer: float = 0 : 
	set (new_value):
		player_movement_hold_timer = new_value
		player_movement_hold_timer = clampf(player_movement_hold_timer, 0, 1)
		#print (player_movement_hold_timer)
		
func move_left_right(delta: float):
	var horizontal_input := Input.get_axis("left", "right") 
	direction = Vector2(horizontal_input, 0)
	
	if direction.x != previous_direction.x:
		player_movement_hold_timer = 0.25 # reset when a to d
		

	player_movement_hold_timer += delta

	var target_speed := acceleration_curve.sample(player_movement_hold_timer) * player_speed * direction.x
	velocity.x = target_speed
	#print (velocity.x)
	previous_direction = direction
	
func try_coyote_strafe():
	coyote_strafe_time.start()

func _on_strafe_timer_timeout() -> void:
	if not direction:
		is_intent_to_move = false
	else:
		is_intent_to_move = true
		
func apply_gravity(_delta):
	velocity.y += player_gravity * _delta
	#move_and_slide()

func handle_jump():
	if not is_jumped:
		var target_height := sqrt(max_jump_height * player_gravity * 2)
		#print (target_height)
		velocity.y = -target_height
		is_jumped = true
	if not Input.is_action_pressed("jump"):
		velocity *= 0.87

func handle_coyote_jump():
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
