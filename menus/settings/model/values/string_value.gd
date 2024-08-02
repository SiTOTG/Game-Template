class_name StringValue
extends Value

@export var value: String = "Placeholder":
	set(v):
		value = v
		data["value"] = v

func load_data(data_: Dictionary):
	value = data_["value"]
