extends Control

@onready var volume_setting: PersistentNode = MyGameSettings.find_child("Volume") as PersistentNode	

func _on_save_button_pressed() -> void:
	MyGameSettings.persist()


func _on_save_volume_button_pressed() -> void:
	if not volume_setting:
		push_error("Volume setting not found. Please check if node name matches.")
		return
	volume_setting.persist()
