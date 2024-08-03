extends "res://menus/settings/base/option_value_control.gd"

@export var soundbus := "Master"

@onready var bus_index := AudioServer.get_bus_index(soundbus)

func get_value() -> String:
	print("toggled")
	return str(%MuteCheckButton.button_pressed)
	

func load_value(_value):
	print("toggled")
	%MuteCheckButton.button_pressed = _value == "true"


func _on_mute_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(bus_index, toggled_on)
