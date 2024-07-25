@tool
extends OptionsValueControl

@export var placeholder_text: String = "Enter value here":
	set(value):
		placeholder_text = value
		$LineEdit.placeholder_text = value

func _ready() -> void:
	$LineEdit.placeholder_text = placeholder_text

func get_value() -> String:
	return $LineEdit.text

func load_value(value: String):
	$LineEdit.text = value
