class_name Field
extends Resource

@export var name: StringName = &""
@export var value: Value:
	set(new_value):
		if value and value.persist_request.is_connected(persist_value):
			value.persist_request.disconnect(persist_value)
		value = new_value
		connect_signals.call_deferred()

func connect_signals():
	if not value.persist_request.is_connected(persist_value):
		value.persist_request.connect(persist_value)

signal persist_request(value: Dictionary)

func persist_value(data: Dictionary):
	print("Emmitted from field")
	persist_request.emit(
		{
			name: data
		}
	)

func persist():
	persist_request.emit(get_dict())

func get_dict() -> Dictionary:
	return {
		name: value.get_dict()
	}

func load_data(data: Dictionary):
	value.load_data(data)
