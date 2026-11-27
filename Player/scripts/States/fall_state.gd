extends State

@export var move_state: State
@export var idle_state: State 
@export var jump_state: State 


@export var player_base: PlayerBase
@onready var ground_check: RayCast2D = %groundCheck

var try_buffer: bool = false
var buffer_time_set: float = 0.3
var buffer_time: float

func enter_state() -> void:
	try_buffer = false
	buffer_time = buffer_time_set
func update(_delta : float) -> void:
	if not try_buffer:
		buffer_time -= _delta
	if buffer_time <= 0:
		if Input.is_action_just_pressed("jump"):
			try_buffer = true
			
func physics_update(_delta : float) -> void:
	player_base.apply_gravity(_delta)
	player_base.move_left_right(_delta)
	
		
	if ground_check.is_colliding() and player_base.velocity.x:
		switch_state.emit(move_state)
	if ground_check.is_colliding() and not player_base.velocity.x:
		switch_state.emit (idle_state)
	#add jump buffering
	
	if try_buffer and ground_check.is_colliding():
		switch_state.emit(jump_state)
