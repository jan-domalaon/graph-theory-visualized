extends Control

var post_intro_played : bool = false

func _ready():
	set_process_input(true)


func _input(event):
	if (event.is_action_pressed("ui_accept")):
		# End Intro animation
		end_intro()

func end_intro() -> void:
	if (not post_intro_played):
		if $AnimationPlayer.get_current_animation() == "Intro":
			# Set properties of animation to default if Intro is still playing
			$AnimationPlayer.seek(2)
		$AnimationPlayer.play("Post Intro")
		post_intro_played = true

func _on_Play_pressed():
	SceneChangeTransition.change_scene_transition("res://menu/ModuleMenu.tscn", $VBoxContainer/ButtonContainer)


func _on_Exit_pressed():
	get_tree().quit()


func _on_Settings_pressed():
	pass # Replace with function body.



