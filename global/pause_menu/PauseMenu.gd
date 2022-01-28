extends Control


onready var is_game_paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Start hidden in interactive scene
	self.hide()


func _input(event):
	if (event.is_action_pressed("ui_cancel")):
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
	is_game_paused = true
	get_tree().set_pause(true)
	self.show()


func toggle_pause() -> void:
	is_game_paused = not is_game_paused


func _on_Resume_pressed():
	resume_game()


func _on_Restart_pressed():
	pass # Replace with function body.


func _on_ExitSection_pressed():
	resume_game()
	SceneChangeTransition.change_scene_transition("res://menu/ModuleMenu.tscn", $CenterContainer/VBoxContainer/ButtonContainer)



