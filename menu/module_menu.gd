extends Control

var selected_chapter : String = ""
var selected_chapter_data : String = ""
var is_chapter_interactive : bool = false

func _on_BackButton_pressed():
	SceneChangeTransition.change_scene_transition("res://menu/MainMenu.tscn")


func _on_ModuleTreeView_signal_update_tree_item_desc(chapter_desc):
	$VBoxContainer/HBoxContainer/DescriptionBox/DescriptionLabel.set_bbcode(chapter_desc)


func _on_ModuleTreeView_signal_selected_chapter():
	$HBoxContainer/PlayButton.show()


func _on_ModuleTreeView_signal_selected_module():
	$HBoxContainer/PlayButton.hide()


func _on_PlayButton_pressed():
	# Interactive sections run Godot scenes. Non-interactive chapters play Youtube animation
	if is_chapter_interactive:
		SceneChangeTransition.change_scene_transition(selected_chapter_data, $HBoxContainer)
	else:
		# Open to associated Youtube animation
		OS.shell_open(selected_chapter_data)


func _on_ModuleTreeView_signal_play_location(play_location, is_interactive):
	# Get selected chapter and chapter data location
	selected_chapter_data = play_location
	is_chapter_interactive = is_interactive
