extends State

@export var move_state : State
@export var fall_state : State
@export var jump_state : State
@onready var ground_check: RayCast2D = %groundCheck


func enter_state() -> void:
	pass
	
func update(_delta : float) -> void:
	var horizontal_input := Input.get_axis("left", "right") 
	var direction = Vector2(horizontal_input, 0)
	
	
	if direction != Vector2.ZERO:
		switch_state.emit(move_state)
	if ground_check.is_colliding() == false:
		switch_state.emit(fall_state)
	if Input.is_action_just_pressed("jump"):
		switch_state.emit (jump_state)
