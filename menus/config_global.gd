extends Node

var config_file_name: String = "user://config.json"

func get_config_json() -> Dictionary:
	if FileAccess.file_exists(config_file_name):
		var file = FileAccess.open(config_file_name, FileAccess.READ)
		var json = JSON.parse_string(file.get_as_text())
		print(JSON.stringify(json, "\t"))
		return json
	else:
		push_warning("Could not find config file, returning default config.")
		return {
			"version": "1.0.0"
		}

func save_values(config: Dictionary) -> void:
	var current = get_config_json()
	current.merge(config, true)
	var file = FileAccess.open(config_file_name, FileAccess.WRITE)
	file.store_string(JSON.stringify(current))
	print(JSON.stringify(current, "\t"))
