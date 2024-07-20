@tool
extends EditorPlugin

const config_pane_scene = preload("res://addons/sitotgmaincontroller/config_pane/config_pane.tscn")

var config_pane: _SitotgConfigPane

func _enter_tree() -> void:
	config_pane = config_pane_scene.instantiate()
	add_control_to_bottom_panel(config_pane, "Config SiTOTG")


func _exit_tree() -> void:
	remove_control_from_bottom_panel(config_pane)
	config_pane.queue_free()
