class_name OptionsValueControl
extends Control

@export var key: String = "value"

func get_value() -> String:
	return "value"

func load_value(_value):
	pass

# Tools part
func _ready() -> void:
	update_configuration_warnings()
	tree_entered.connect(update_configuration_warnings)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	var parent = get_parent()
	if not parent is OptionsMenuPersistentItem:
		warnings.append("This should be a child of OptionsMenuPersistentItem")
	return warnings
