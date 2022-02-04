# Pause Menu. Handles Resume, Restart and Return to Module Menu
# This menu's pause mode is set to Process. Always running when opened
extends Control


# This works as long as PauseMenu is one level down the parent node
onready var parent_filepath : String = get_parent().filename 
onready var is_game_paused : bool = false


func _ready():
	# Start hidden in interactive scene
	self.hide()
	set_process_input(true)


func _input(event):
	if (Input.is_action_pressed("ui_cancel")):
		if not is_game_paused:
			pause_game()
		else:
			resume_game()


func resume_game() -> void:
	# Resume pause game state
	is_game_paused = false
	get_tree().set_pause(false)
	self.hide()


func pause_game() -> void:
	# Pause game state
	self.show()
	is_game_paused = true
	get_tree().set_pause(true)


func _on_Resume_pressed():
	resume_game()


func _on_Restart_pressed():
	# Unpause game and change scene to same scene
	get_tree().paused = false
	SceneChangeTransition.change_scene_transition(parent_filepath, $CenterContainer/VBoxContainer/ButtonContainer)


func _on_ExitSection_pressed():
	resume_game()
	SceneChangeTransition.change_scene_transition("res://menu/ModuleMenu.tscn", $CenterContainer/VBoxContainer/ButtonContainer)
