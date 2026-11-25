extends State

@export var player_base: PlayerBase
@export var fall_state: State
@onready var ground_check: RayCast2D = %groundCheck

func enter_state() -> void:
	player_base.is_jumped = false

func physics_update(_delta : float) -> void:
	player_base.handle_jump() #convert to function in player_base
	
	player_base.apply_gravity(_delta)
	player_base.move_left_right(_delta)
	
	if player_base.velocity.y > 0:
		switch_state.emit(fall_state)

func exit_state() -> void:
	player_base.is_jumped = false
