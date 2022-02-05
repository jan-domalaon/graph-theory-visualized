# 1 second timer that decrements count. Count is the number of real life seconds
extends Timer

export var total_seconds: int = 5
onready var seconds_left: int = total_seconds

signal signal_timer_display(output)
signal signal_counted_down(seconds_left)
signal signal_countdown_done

func _ready():
	# Connect timeout signal to self to reset 1 second timer
	self.connect("timeout", self, "_on_self_timeout")
	self.connect("signal_counted_down", self, "_on_self_counted_down")


func _on_self_timeout() -> void:
	emit_signal("signal_counted_down", seconds_left)
	seconds_left -= 1
	# Ony stop timer if there are no more seconds left
	if seconds_left >= 0:
		# Start timer again to run another second
		start()
	else:
		# Don't run timer when there are no more seconds. 
		stop()
		# Emit signal to update sequence
		emit_signal("signal_countdown_done")


func start_timer() -> void:
	# Reset seconds left count and start 1 second timer
	seconds_left = total_seconds
	start()


func _on_self_counted_down(_seconds_left: int) -> void:
	# Emit signal to output to terminal
	var _formatted_msg: String = String(seconds_left) + "\n"
	emit_signal("signal_timer_display", _formatted_msg)
