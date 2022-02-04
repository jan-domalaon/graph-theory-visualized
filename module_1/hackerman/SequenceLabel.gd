# SequenceLabel handles the output of the label.
# Processing of the sequenceo ccurs in Hackerman script
extends Label


func update_sequence_display(_new_sequence: Array) -> void:
	# Update sequence being displayed. Create new string
	var _sequence_to_display: String = ""
	for i in range(0, _new_sequence.size() - 1):
		if i < _new_sequence.size() - 2:
			_sequence_to_display = _sequence_to_display + String(_new_sequence[i]) + " "
		else:
			# If i == sequence size - 2 (last number), then display without a space
			_sequence_to_display = _sequence_to_display + String(_new_sequence[i])
	# Finally, output text
	set_text(_sequence_to_display)
