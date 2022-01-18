extends Control


func _ready() -> void:
	set_process_input(true)

func _input(event) -> void:
	# Skip instantly to main menu
	if (event.is_action_pressed("ui_accept")):
		get_tree().change_scene("res://menu/MainMenu.tscn")

func go_to_main_menu() -> void:
	get_tree().change_scene("res://menu/MainMenu.tscn")
