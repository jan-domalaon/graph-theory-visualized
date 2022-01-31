# "Terminal Input" mainly sends a command when the player hits Enter
# Send inputted command to parent

extends LineEdit


signal enter_command(command)

func _ready():
	set_process_input(true)


func _input(event):
	if (Input.is_action_just_pressed("enter_terminal")):
		# Send inputted command to parent. Parent handles output handling
		# Only send when there is actually something in the terminal input
		var terminal_input : String = get_text()
		if terminal_input != "":
			emit_signal("enter_command", terminal_input)
			
			# Clear text for new command input
			clear()		
