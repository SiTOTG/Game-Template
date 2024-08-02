class_name PersistentNode extends Node

@export var field_name: String

signal persist_request(data: Dictionary)

func _ready() -> void:
	for node in get_children():
		var persistent_node := node as PersistentNode
		if not persistent_node: continue
		persistent_node.persist_request.connect(persist_single)
	

func persist():
	persist_request.emit(
		get_json()
	)

func persist_single(data: Dictionary):
	persist_request.emit(
		{
			field_name: data
		}
	)

func get_json():
	var data: = {}
	for node in get_children():
		var persistent_node := node as PersistentNode
		if not persistent_node: continue
		data.merge(persistent_node.get_json())
	return {
		field_name: data
	}
