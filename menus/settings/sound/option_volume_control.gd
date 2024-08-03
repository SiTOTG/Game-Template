extends "res://menus/settings/base/option_value_control.gd"

@export var soundbus := "Master"

@onready var bus_index := AudioServer.get_bus_index(soundbus)

func get_value() -> String:
	return str(%VolumeSlider.value)

func load_value(_value):
	%VolumeSlider.value = int(_value)
	
	


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, %VolumeSlider.value)
