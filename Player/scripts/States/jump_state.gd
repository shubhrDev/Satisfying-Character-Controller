extends State

@export var player_base: PlayerBase
@export var fall_state: State
@onready var ground_check: RayCast2D = %groundCheck


var apex_modifier_applied: bool

func enter_state() -> void:
	player_base.handle_jump() #convert to function in player_base
	

func physics_update(_delta : float) -> void:
	
	player_base.apply_gravity(_delta)
	player_base.apex_modifier()
	player_base.move_left_right(_delta)
	
	if player_base.velocity.y > 0:
		switch_state.emit(fall_state)
