extends Node2D

@export var mainScene: PackedScene

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(mainScene)
