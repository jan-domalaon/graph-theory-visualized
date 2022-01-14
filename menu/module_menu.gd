extends Control


func _on_BackButton_pressed():
	SceneChangeTransition.change_scene_transition("res://menu/main_menu.tscn")


func _on_ModuleTree_signal_update_chapter_desc(chapter_desc):
	$VBoxContainer/HBoxContainer/DescriptionBox/DescriptionLabel.set_bbcode(chapter_desc)


func _on_ModuleTree_signal_selected_chapter():
	$HBoxContainer/PlayButton.show()


func _on_ModuleTree_signal_selected_module():
	$HBoxContainer/PlayButton.hide()
