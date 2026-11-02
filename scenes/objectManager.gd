extends ColorRect

@export var answer: String
var answered = false
var secretManager: Node2D
@onready var label = $Label

func _ready() -> void:
	secretManager = get_parent().get_parent()

func _on_mouse_entered() -> void:
	if (!answered):
		print("yeah")
		secretManager.setSelectedObject(self, answer)

func _on_mouse_exited() -> void:
	if (!answered):
		print("no")
		secretManager.clearSelectedObject()

func setAnswered() -> void:
	answered = true
	label.visible = true
