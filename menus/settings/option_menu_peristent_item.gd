@tool
class_name OptionsMenuPeristentItem
extends HBoxContainer

@export var section: String = "CustomSection"

@export var config_name: String:
	set(value):
		if value != config_name:
			var label = get_node_or_null("OptionNameLabel")
			if label:
				label.text = value
			config_name = value

func persist() -> void:
	var persist_value = get_persist_value()
	ConfigGlobal.save_values(persist_value)

func get_persist_value() -> Dictionary:
	var children = get_children()
	var persist_value := {}
	var value_controls = children.filter(
		func is_value_control(node: Node):
			return node is OptionsValueControl
	)
	
	for value_control in value_controls:
		if value_control.key in persist_value:
			push_error("Error, multiple value controls with the same key")
			continue
		persist_value[value_control.key] = value_control.get_value()

	return {
		section: {
			config_name: persist_value
		}
	}
