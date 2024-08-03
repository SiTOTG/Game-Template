extends "res://menus/settings/base/option_value_control.gd"

var devices: PackedStringArray

var device_idx: Dictionary = {}

func _ready() -> void:
	devices = AudioServer.get_output_device_list()
	for idx in range(len(devices)):
		var device = devices[idx]
		device_idx[device] = idx
		%AudioDeviceDropdown.add_item(device)

func get_value() -> String:
	return %AudioDeviceDropdown.get_item_text(%AudioDeviceDropdown.get_selected_id())

func load_value(_value):
	%AudioDeviceDropdown.select(device_idx[_value])

func _on_audio_device_dropdown_item_selected(index: int) -> void:
	AudioServer.output_device = %AudioDeviceDropdown.get_item_text(index)
