extends State

@export var move_state : State


func enter_state() -> void:
	pass
	
func update(_delta : float) -> void:
	var horizontal_input := Input.get_axis("left", "right") 
	var direction = Vector2(horizontal_input, 0)
	if direction != Vector2.ZERO:
		
		switch_state.emit(move_state)
