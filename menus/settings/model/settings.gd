extends Node

func _ready() -> void:
	for node in get_children():
		var persistent_node := node as PersistentNode
		if not persistent_node: continue
		persistent_node.persist_request.connect(persist_single)

func persist():
	print("Saving the following: ", JSON.stringify(get_json(), "\t"))

func persist_single(data: Dictionary):
	print("Saving the following: ", JSON.stringify(data, "\t"))

func get_json() -> Dictionary:
	var data: = {}
	for node in get_children():
		var persistent_node := node as PersistentNode
		if not persistent_node: continue
		data.merge(persistent_node.get_json())
	return data
