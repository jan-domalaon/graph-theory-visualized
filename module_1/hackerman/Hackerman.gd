extends Node

const COMMAND_LIST : Array = ["help", "help -a", "exit",\
"graphical", "graphical -a", "havelhakimi", "hhreduce", "network", "network -n",\
"averagemathenjoyer", "bestuni", "bruhmoment", "neco", "gtvstats",\
"inthemainframe","inthemainframe -p"]
const INVALID_OUTPUT_MSG : String = "Invalid command input."

var hh_reduce_count : int = 3
var command_dict : Dictionary = {}

var degree_sequence_dict : Dictionary = {}

export var boot_msg_filepath : String = "res://module_1/hackerman/boot_msg.txt"

# Signals to emit to children
# Signals used instead of direct node path as node structure may change
signal output_terminal(terminal_msg)

func _enter_tree():
	# Create command dictionary. Used to assign commands to its terminal output
	command_dict = create_command_dict(COMMAND_LIST)
	# Load the prompts and sequences
	load_prompts()
	load_degree_sequences()


func _ready():
	# Print out terminal flavour text
	output_to_terminal(get_boot_msg())


func create_command_dict(_command_list : Array) -> Dictionary:
	var _command_dict : Dictionary = {}
	for command in _command_list:
		_command_dict = {command: "\n"}
	return _command_dict


func load_prompts() -> void:
	pass


func load_degree_sequences() -> void:
	pass


func output_to_terminal(_output_message : String) -> void:
	var formatted_output_msg : String = _output_message + "\n"
	emit_signal("output_terminal", formatted_output_msg)


func get_boot_msg() -> String:
	var _boot_msg_file = File.new()
	if _boot_msg_file.file_exists(boot_msg_filepath):
		_boot_msg_file.open(boot_msg_filepath, File.READ)
		var data = _boot_msg_file.get_as_text()
		return data
	else:
		return ""
	_boot_msg_file.close()


func handle_command(_command : String) -> void:
	pass


func _on_TerminalInput_enter_command(command) -> void:
	# Find matching command in command dictionary
	if command in command_dict.keys():
		pass
	else:
		# If not found, output error message
		output_to_terminal(INVALID_OUTPUT_MSG)
