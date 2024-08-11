extends "res://menus/settings/base/option_value_control.gd"

@export var feedback_stream: AudioStream
@export var soundbus := "Master"

@onready var bus_index := AudioServer.get_bus_index(soundbus)

func _ready() -> void:
	if feedback_stream:
		$AudioFeedback.stream = feedback_stream
		$AudioFeedback.bus = soundbus

func get_value() -> String:
	return str(%VolumeSlider.value)

func load_value(_value):
	%VolumeSlider.value = int(_value)

func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, %VolumeSlider.value)
	if %VolumeSlider.has_focus() and feedback_stream:
		$AudioFeedback.play()
