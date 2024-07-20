extends TabContainer


func _on_apply_pressed() -> void:
	var options = %SettingsOptions.get_children()

	var persist_value := {}

	for option in options:
		option = option as OptionsMenuPeristentItem
		if not option: continue
		persist_value.merge(option.get_persist_value(), true)

	ConfigGlobal.save_values(persist_value)
