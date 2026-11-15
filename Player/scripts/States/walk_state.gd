extends State

class_name WalkState
const SPEED = 300.0
@onready var strafe_timer: Timer = %strafeTimer



func physics_update(delta : float): 
	var character_controller = state_machine.get_parent()
	var direction := Input.get_axis("left", "right")
	
	if direction == 0:
		strafe_timer.start()
	else:
		strafe_timer.stop()

	if direction:
		character_controller.velocity.x = direction * SPEED
	else:
		character_controller.velocity.x = move_toward(character_controller.velocity.x, 0, SPEED)

	character_controller.move_and_slide()

func handle_input(event : InputEvent):
	if event.is_action_pressed("jump"):
		state_machine.change_state("jumpstate")
	


func _on_strafe_timer_timeout() -> void:
		state_machine.change_state("idlestate")
	
