extends State

@export var idle_state : State
@export var jump_state : State
@export var fall_state : State

@export var player_base: PlayerBase
@onready var ground_check: RayCast2D = %groundCheck


func update(_delta : float) -> void:
	
	if not player_base.direction.x and player_base.coyote_strafe_time.is_stopped():
		player_base.try_coyote_strafe()
	
func physics_update(_delta : float) -> void:
	player_base.move_left_right( _delta)
	if Input.is_action_just_pressed("jump"):
		switch_state.emit(jump_state)
	if not ground_check.is_colliding():
		switch_state.emit(fall_state)
func _on_strafe_timer_timeout() -> void:
	if not player_base.is_intent_to_move:
		switch_state.emit(idle_state)
