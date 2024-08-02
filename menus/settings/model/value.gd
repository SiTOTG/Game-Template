class_name Value
extends Resource

signal persist_request(data: Dictionary)

var data: Dictionary

func persist():
	persist_request.emit(
		get_dict()
	)

func get_dict():
	return data

func load_data(data_: Dictionary):
	data = data_
