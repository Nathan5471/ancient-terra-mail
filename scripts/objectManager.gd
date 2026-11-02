extends ColorRect

@export var answer: String
var answered = false
var selected = false
var secretManager: Node2D
@onready var label = $Label

func _ready() -> void:
	secretManager = get_parent().get_parent()

func _process(delta: float) -> void:
	if (!answered):
		var myRect: Rect2 = get_global_rect()
		if myRect.has_point(get_global_mouse_position()):
			if (selected == true):
				return
			secretManager.setSelectedObject(self, answer)
			selected = true
		elif (selected == true):
			secretManager.clearSelectedObject()
			selected = false

func setAnswered() -> void:
	answered = true
	label.visible = true
