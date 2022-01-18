extends Control

var selected_chapter : String = ""

func _on_BackButton_pressed():
	SceneChangeTransition.change_scene_transition("res://menu/MainMenu.tscn")


func _on_ModuleTreeView_signal_update_tree_item_desc(chapter_desc):
	$VBoxContainer/HBoxContainer/DescriptionBox/DescriptionLabel.set_bbcode(chapter_desc)


func _on_ModuleTreeView_signal_selected_chapter():
	$HBoxContainer/PlayButton.show()


func _on_ModuleTreeView_signal_selected_module():
	$HBoxContainer/PlayButton.hide()


func _on_PlayButton_pressed():
	pass
