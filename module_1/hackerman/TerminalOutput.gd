# "Terminal output" - handles printing messages from Hackerman node
# Commands are handled in parent node

extends RichTextLabel


func _ready():
	# Clear any text set
	clear()


func _on_Hackerman_output_terminal(terminal_msg):
	append_bbcode(terminal_msg)
