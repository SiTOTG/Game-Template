extends Panel

@export var fields: Array[OptionsMenuPeristentItem] = []

func _ready() -> void:
	#for field in fields
	pass

func apply():
	var persist_value := {}
	for field in fields:
		persist_value.merge(field.get_persist_value(), true)

	ConfigGlobal.save_values(persist_value)

func load():
	var data = ConfigGlobal.get_config_json()
	for field in fields:
		field.load_value(data)
