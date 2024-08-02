extends PersistentNode

@export var value: String

func get_json():
	return {
		field_name: value
	}

func persist_single(_data: Dictionary):
	persist()
