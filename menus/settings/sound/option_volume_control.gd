extends "res://menus/settings/base/option_value_control.gd"

func get_value() -> String:
	return str(%VolumeSlider.value)

func load_value(_value):
	%VolumeSlider.value = int(_value)
