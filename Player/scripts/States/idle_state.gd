extends State

class_name IdleState

func enter():
	print ("Entering Idle State")
	
func handle_input(event : InputEvent):
	if event.is_action_pressed("left") or event.is_action_pressed("right"):
		state_machine.change_state("walkstate")
	elif event.is_action_pressed("jump"):
		state_machine.change_state("jumpstate")
