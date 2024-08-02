extends Control

@export var settings: Settings

@export_group("Test value targets")
@export var test_persist_section_target: Section
@export var test_persist_field_target: Field
@export var test_persist_value_target: Value

func _on_call_persist_button_item_selected(index: int) -> void:
	# First item is a header
	if index == 0:
		return
	var item = %CallPersistButton.get_item_text(index)
	%CallPersistButton.select(0)
	match item:
		"Section":
			test_persist_section_target.persist()
		"Field":
			test_persist_field_target.persist()
		"Value":
			test_persist_value_target.persist()
		"Settings":
			settings.persist()


func _on_custom_button_pressed() -> void:
	var section = settings.sections[0]
	print("Section: ", section)
	section.persist_request.emit({})
	print(section.persist_request.is_connected(settings.persist_section))


func _on_load_button_pressed() -> void:
	settings.load_data()
