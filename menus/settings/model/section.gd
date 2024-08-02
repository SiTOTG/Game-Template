class_name Section
extends Resource

@export var name: StringName = &""
@export var fields: Array[Field]:
	set(value):
		fields = value
		connect_signals.call_deferred()

func connect_signals():
	for field in fields:
		if field and not field.persist_request.is_connected(persist_field):
			field.persist_request.connect(persist_field)

signal persist_request(value: Dictionary)

func persist_field(value: Dictionary):
	persist_request.emit(
		{
			name: value
		}
	)

func persist():
	persist_request.emit(get_dict())

func get_dict() -> Dictionary:
	var value = {}
	for field in fields:
		if field and field.name in value:
			push_error("Field name duplicated, values will be merged!")
		value.merge(field.get_dict())
	return {
		name: value
	}

func load_data(data: Dictionary):
	for field in fields:
		if field.name in data:
			field.load_data(data[field.name])
