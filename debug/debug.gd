extends Node

var current_config := {}

func _ready() -> void:
	current_config = ConfigGlobal.get_config_json()
