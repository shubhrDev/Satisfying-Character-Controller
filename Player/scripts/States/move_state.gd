extends State

@export var idle_state : State
@onready var strafe_timer: Timer = %strafeTimer
@export var player_base: PlayerBase
var timer_started : bool = false
var direction



func enter_state() -> void:
	player_base.player_movement_hold_timer = 0
	
func update(_delta : float) -> void:
	var horizontal_input := Input.get_axis("left", "right") 
	direction = Vector2(horizontal_input, 0)
	
	if direction == Vector2.ZERO and player_base.coyote_strafe_time.is_stopped():
		player_base.coyote_strafe_time.start()
	else:
		player_base.move_left_right(direction, _delta)
	
		


func _on_strafe_timer_timeout() -> void:
	if direction == Vector2.ZERO:
		switch_state.emit(idle_state)
	
		
