extends "res://global/generic_interactive/win_loss_interface.gd"


const TERMINAL_OUTPUT_LOSE = "[color=red]Network breach detected! Sequence is incorrect or time has ran out![/color]"
const TERMINAL_OUTPUT_WIN = "[color=green]YOU WON! All networks have been breached and you pwn'd the system![/color]"

signal output_terminal(terminal_msg)

func lose_stage() -> void:
	emit_signal("output_terminal", TERMINAL_OUTPUT_LOSE)


func win_stage() -> void:
	emit_signal("output_terminal", TERMINAL_OUTPUT_WIN)


func _on_GameSection_signal_lose_stage():
	lose_stage()


func _on_GameSection_signal_win_stage():
	win_stage()
