extends Node


const JSON_FILE_EXTENSION = ".json"
const TEXT_FILE_EXTENSION = ".txt"

func import_file(_filepath : String):
	var _data_to_export = null
	var _file = File.new()
	if _file.file_exists(_filepath):
		_file.open(_filepath, File.READ)
		var file_data = null
		if JSON_FILE_EXTENSION in _filepath:
			file_data = parse_json(_file.get_as_text())
		elif TEXT_FILE_EXTENSION in _filepath:
			file_data = _file.get_as_text()
		_data_to_export = file_data
	_file.close()
	return _data_to_export
