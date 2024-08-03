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

func load_value(config: Dictionary) -> void:
	if (
		section in config
		and config_name in config[section]
	):
		var data = config[section][config_name]
		var children = get_children()
		for value_control in children:
			value_control = value_control as OptionsValueControl
			if value_control:
				if value_control.key in data:
					value_control.load_value(data[value_control.key])


## Tools part
func _ready() -> void:
	if Engine.is_editor_hint():
		child_entered_tree.connect(update_configuration_warnings.unbind(1))

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if not get_children().any(
		func(child):
			return child is OptionsValueControl
	):
		warnings.append("This node is useless without OptionsValueControl below it")

	return warnings
