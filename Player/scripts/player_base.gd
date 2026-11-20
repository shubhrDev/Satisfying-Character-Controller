class_name PlayerBase extends CharacterBody2D

@export var acceleration_curve : Curve
@export var player_speed : float
@export var coyote_strafe_time : Timer
var previous_direction : Vector2
var player_movement_hold_timer: float = 0 : 
	set (new_value):
		player_movement_hold_timer = new_value
		player_movement_hold_timer = clampf(player_movement_hold_timer, 0, 1)
		#print (player_movement_hold_timer)
		
func move_left_right(direction: Vector2, delta: float):
	if direction.x != previous_direction.x:
		player_movement_hold_timer = 0.25 # reset when a to d
		

	player_movement_hold_timer += delta

	var target_speed := acceleration_curve.sample(player_movement_hold_timer) * player_speed * direction.x
	velocity.x = target_speed

	previous_direction = direction

	move_and_slide()
