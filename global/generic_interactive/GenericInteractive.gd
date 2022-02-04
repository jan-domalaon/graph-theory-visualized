extends Node


const PLAY_STAGE: String = "PLAYING"
const WIN_STAGE: String = "WIN"
const LOSE_STAGE: String = "LOSE"

var current_stage: String

signal signal_lose_stage
signal signal_win_stage

func _enter_tree():
	current_stage = PLAY_STAGE


func change_game_stage(_new_stage: String) -> void:
	current_stage = _new_stage
