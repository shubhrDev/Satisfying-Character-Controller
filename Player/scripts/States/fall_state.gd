extends State

@export var move_state: State
@export var idle_state: State 
@export var player_base: PlayerBase
@onready var ground_check: RayCast2D = %groundCheck


func physics_update(_delta : float) -> void:
	player_base.apply_gravity(_delta)
	player_base.move_left_right(_delta)

	if ground_check.is_colliding() and player_base.velocity.x:
		switch_state.emit(move_state)
	if ground_check.is_colliding() and not player_base.velocity.x:
		switch_state.emit (idle_state)
