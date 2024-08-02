class_name Settings
extends Resource

const CURR_VERSION = "1.0"
const SAVE_FILE_PATH_PREFIX = "user://"

@export var save_file_name := &"save.json"
@export var sections: Array[Section] = []:
	set(value):
		sections = value
		connect_signals.call_deferred()

func connect_signals():
	for section in sections:
		if not section.persist_request.is_connected(persist_section):
			section.persist_request.connect(persist_section)

func persist_section(value: Dictionary):
	persist_dict(value)

func persist():
	persist_dict(get_dict())

func get_dict() -> Dictionary:
	var data = {}
	var value = {
		"data": data
	}
	for section in sections:
		if section.name in data:
			push_error("Section name duplicated, values will be merged!")
		data.merge(section.get_dict())
	return value

func persist_dict(dict: Dictionary) -> void:
	var current_dict = get_current_save_dict()
	current_dict.merge(dict, true)
	var save_file = FileAccess.open(SAVE_FILE_PATH_PREFIX + save_file_name, FileAccess.WRITE)
	if save_file and save_file.is_open():
		var save_content := JSON.stringify(current_dict, "\t")
		print("Saving content: ", save_content)
		save_file.store_string(save_content)
		save_file.close()
	else:
		var error = FileAccess.get_open_error()
		push_error("Unable to save file! Error opening file ", error)
		

func get_current_save_dict() -> Dictionary:
	var current_dict : Dictionary
	if FileAccess.file_exists(SAVE_FILE_PATH_PREFIX + save_file_name):
		var current_save = FileAccess.get_file_as_string(SAVE_FILE_PATH_PREFIX + save_file_name)
		current_dict = JSON.parse_string(current_save)
	else:
		current_dict = {
			"data": "",
			"version": CURR_VERSION
		}
	return current_dict

func load_data():
	var save_content = get_current_save_dict()
	var data = save_content["data"]
	for section in sections:
		if section.name in data:
			section.load_data(data[section.name])
	print("New value: ", get_dict())
