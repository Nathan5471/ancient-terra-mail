extends Node2D

@export var mainScene: PackedScene
@export var secretScene: PackedScene

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(mainScene)


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_packed(secretScene)
