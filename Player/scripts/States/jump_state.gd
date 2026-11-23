extends State

@export var player_base: PlayerBase
@export var fall_state: State

@onready var ground_check: RayCast2D = %groundCheck
@onready var apex_modifier_time: Timer = %apexModifierTime

var apex_modifier_applied: bool

func enter_state() -> void:
	player_base.handle_jump() #convert to function in player_base
	apex_modifier_applied = false

func physics_update(_delta : float) -> void:
	if apex_modifier_time.is_stopped():
		player_base.apply_gravity(_delta)
		
	player_base.move_left_right(_delta)

	if not ground_check.is_colliding() and absf(player_base.velocity.y) < 30 and not apex_modifier_applied: 
		#Apex modifiers increase horizontal speed and antigravity moment
		#print("do something")
		player_base.apex_modifier()
		apex_modifier_time.start()
		#print (apex_modifier_time.is_stopped())
		await apex_modifier_time.timeout
		print ("reset")
		apex_modifier_applied = true
		
		player_base.reset_apex_modifier()
		apex_modifier_time.stop()
		
	if not ground_check.is_colliding() and player_base.velocity.y > 0.0 and apex_modifier_applied:
		switch_state.emit (fall_state)
	
	if Input.is_action_just_released("jump"):
		player_base.velocity.y *= 0.4
		print (player_base.velocity.y)
		print ("release")
func exit_state() -> void:
	apex_modifier_applied = false
	player_base.reset_apex_modifier()
	apex_modifier_time.stop()
