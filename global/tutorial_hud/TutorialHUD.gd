# TutorialHUD needs children Control nodes defined by the individual interactive section
# TutorialHUD just handles input and sequence of tutorial screens to show.

extends Control


export var has_tutorial : bool = false
var is_tutorial_done : bool = false
var current_tutorial_screen_index : int = 0

# Sequence of tutorials screen. Empty array if there are no tutorial screens
onready var array_tutorial_screens : Array = $TutorialScreens.get_children()


func _ready():
	if has_tutorial:
		self.show()
		set_process_input(true)
	else:
		self.hide()
		set_process_input(false)
	#print(array_tutorial_screens)
	print(array_tutorial_screens.size())


func _input(event):
	if (Input.is_action_pressed("ui_left")):
		previous_tutorial_screen()
	elif (Input.is_action_pressed("ui_right")):
		forward_tutorial_screen()


func forward_tutorial_screen() -> void:
	if not at_end_of_tutorial():
		tutorial_screen_visibility(current_tutorial_screen_index, current_tutorial_screen_index + 1)
		current_tutorial_screen_index += 1


func previous_tutorial_screen() -> void:
	if not at_end_of_tutorial():
		tutorial_screen_visibility(current_tutorial_screen_index, current_tutorial_screen_index - 1)
		current_tutorial_screen_index -= 1


func at_end_of_tutorial() -> bool:
	# Check if there are no more previous screens
	if (current_tutorial_screen_index - 1 < 0):
		return false
	elif (current_tutorial_screen_index + 1 >= array_tutorial_screens.size()):
		return false
	else:
		return true


func tutorial_screen_visibility(_curr_screen_index : int, _next_screen_index : int) -> void:
	array_tutorial_screens[_curr_screen_index].hide()
	array_tutorial_screens[_next_screen_index].show()
