extends "res://global/generic_interactive/GenericInteractive.gd"

const COMMAND_LIST : Array = ["help", "help -a", "exit",\
"graphical", "graphical -Y", "graphical -N", "havelhakimi", "hhreduce", "network", "network -n",\
"averagemathenjoyer", "bestuni", "bruhmoment", "neco", "gtvstats",\
"inthemainframe","inthemainframe -p"]
const INVALID_OUTPUT_MSG : String = "Invalid command input."

# For command_prompts JSON
const PROMPT_CHILDREN_KEY = "children"
const COMMAND_KEY = "command"
const COMMAND_PROMPT_KEY = "terminal_output"

# For sequences JSON
const SEQUENCE_INDEX_KEY = "sequence_index"
const SEQUENCE_KEY = "sequence"
const SEQUENCE_GRAPHICAL_KEY = "is_graphical"

var hh_reduce_count : int = 3
var command_dict : Dictionary = {}

# Form of degree sequence {"index_num": [sequence array, is_graphical]}
var sequences_dict : Dictionary = {}
var current_sequence_index: int = 0

# Filepaths for FluffCommands
onready var fluff_commands = $FluffCommands

export var boot_msg_filepath : String = "res://module_1/hackerman/boot_msg.txt"
export var command_prompts_filepath : String = "res://module_1/hackerman/command_outputs.json"
export var degree_sequences_filepath : String = "res://module_1/hackerman/sequences.json"

# Signals to emit to children
# Signals used instead of direct node path as node structure may change
signal output_terminal(terminal_msg)
signal signal_update_sequence(sequence_array)
signal signal_start_network_timer
signal signal_reset_sequence_timer

func _enter_tree():
	# Create command dictionary. Used to assign commands to its terminal output
	command_dict = initialize_command_dict(COMMAND_LIST)
	# Load the prompts and sequences from text files
	initialize_prompts()
	initialize_degree_sequences()


func _ready():
	# Print out terminal flavour text
	output_to_terminal(get_boot_msg())
	
	#emit_signal("signal_update_sequence", sequences_dict["1"][0])


func initialize_command_dict(_command_list : Array) -> Dictionary:
	var _command_dict : Dictionary = {}
	
	# Load commands in the command list. Input new lines for command output for now.
	for command in _command_list:
		_command_dict[command] = ""
	return _command_dict


func initialize_prompts() -> void:
	# Run FileImport.import_file to get json as dict
	var _command_prompts_json = FileImport.import_file(command_prompts_filepath)
	
	# Initialize prompt for all commands in the command list
	for i in range(0, COMMAND_LIST.size()):
		# Get array of JSONs with command prompts
		var _command_prompts_json_list = _command_prompts_json[PROMPT_CHILDREN_KEY]
		# Only run if i is still within number of children
		if i <= _command_prompts_json_list.size() - 1:
			# Get object from command prompt json children list. Returns a json object
			var _command_json = _command_prompts_json_list[i]
			# Get the equivalent command in command list
			var _command = _command_json[COMMAND_KEY]
			# Assign command prompt in command_dict if there is an associated prompt in the JSON
			command_dict[_command] = _command_json[COMMAND_PROMPT_KEY]
		else:
			pass


func initialize_degree_sequences() -> void:
	# Degree sequences is a JSON file
	var _sequences_json = FileImport.import_file(degree_sequences_filepath)
	# For each JSON in list of JSONs in children, create an entry in degree_sequences_dict
	var _sequences_children_jsons_list : Array = _sequences_json[PROMPT_CHILDREN_KEY]
	for i in range(0, _sequences_children_jsons_list.size()):
		var _sequence_json = _sequences_children_jsons_list[i]
		var _sequence_index = _sequence_json[SEQUENCE_INDEX_KEY]
		var _sequence_array = _sequence_json[SEQUENCE_KEY]
		var _sequence_is_graphical = _sequence_json[SEQUENCE_GRAPHICAL_KEY]
		sequences_dict[_sequence_index] = [_sequence_array, _sequence_is_graphical]


func output_to_terminal(_output_message : String) -> void:
	var formatted_output_msg : String = _output_message + "\n"
	emit_signal("output_terminal", formatted_output_msg)


func get_boot_msg() -> String:
	var _boot_msg_file = File.new()
	if _boot_msg_file.file_exists(boot_msg_filepath):
		_boot_msg_file.open(boot_msg_filepath, File.READ)
		var data = _boot_msg_file.get_as_text()
		_boot_msg_file.close()
		return data
	else:
		_boot_msg_file.close()
		return ""


func handle_command_input(_command : String) -> void:
	# Takes in command from command input and run the function
	match _command:
		"help":
			run_help()
		"help -a":
			run_help(true)
		"exit":
			run_exit()
		"graphical":
			run_graphical(false)
		"graphical -Y":
			run_graphical(true, true)
		"graphical -N":
			run_graphical(true, true)
		"havelhakimi":
			pass
		"hhreduce":
			pass
		"network":
			run_network()
		"network -n":
			run_network(true)
		"averagemathenjoyer", "bestuni", "bruhmoment", "neco":
			run_fluff(_command)
		"gtvstats":
			run_gtvstats()
		"inthemainframe":
			run_inthemainframe()
		"inthemainframe -p":
			run_inthemainframe(true)
		_:
			output_to_terminal(INVALID_OUTPUT_MSG)


func run_help(_show_all: bool = false) -> void:
	if _show_all == true:
		output_to_terminal(command_dict["help -a"])
	else:
		output_to_terminal(command_dict["help"])


func run_exit() -> void:
	# Exit Hackerman
	output_to_terminal(command_dict["exit"])
	SceneChangeTransition.change_scene_transition(CommonSceneChanges.MODULE_MENU_PATH)


func run_graphical(_answer_attempt: bool, _is_graphical: bool = false) -> void:
	if not _answer_attempt:
		# If not an answer attempt, print possible options for the command.
		pass
	else:
		pass


func run_network(_next_network: bool = false) -> void:
	if not _next_network:
		# Print current network level
		output_to_terminal(command_dict["network"])
	else:
		# Run timer before launching new sequence
		run_new_sequence()


func run_new_sequence() -> void:
	# Run countdown. Timer handles countdown output to terminal
	output_to_terminal(command_dict["network -n"])
	emit_signal("signal_start_network_timer")


func run_fluff(_command: String) -> void:
	# Match command and run the appropriate link
	var url_to_launch: String = ""
	match _command:
		"averagemathenjoyer":
			url_to_launch = fluff_commands.SIGMA_MALE
		"bestuni":
			url_to_launch = fluff_commands.BEST_UNI
		"bruhmoment":
			url_to_launch = fluff_commands.BRUHMOMENT
		"neco":
			url_to_launch = fluff_commands.NECO
	output_to_terminal(command_dict[_command])
	OS.shell_open(url_to_launch)


func run_inthemainframe(_is_playlist: bool = false) -> void:
	var url_to_launch: String = ""
	if not _is_playlist:
		url_to_launch = fluff_commands.HASHBROWN_MOMENT
	else:
		url_to_launch = fluff_commands.MAINFRAME_PLAYLIST
	output_to_terminal(command_dict["inthemainframe"])
	OS.shell_open(url_to_launch)


func run_gtvstats() -> void:
	pass


func _on_TerminalInput_enter_command(_command: String) -> void:
	# Print inputted command
	output_to_terminal("> " + _command)
	# Match command in command_dict
	handle_command_input(_command)


func _on_NetworkTimer_signal_countdown_done():
	# Add new sequence when the countdown is done
	# Reset sequence timer
	emit_signal("signal_reset_sequence_timer")
	
	# Incremement sequence index by 1, only if there is still another sequence in sequences_dict
	var _next_seq_index = current_sequence_index + 1
	if (String(_next_seq_index) in sequences_dict.keys()): 
		current_sequence_index += 1
		# Update sequence display
		var _current_sequence_array = sequences_dict[String(current_sequence_index)][0]
		emit_signal("signal_update_sequence", _current_sequence_array)
	else:
		# If there are no more sequences, then the player has won.
		# Update game stage
		change_game_stage(WIN_STAGE)
		emit_signal("signal_win_stage")
	
