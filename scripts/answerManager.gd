extends ColorRect

@export var answer: String
var pickedUp = false
var savedLocation: Vector2
var secretManager: Node2D

func _ready() -> void:
	secretManager = get_parent().get_parent()

func _process(delta: float) -> void:
	if pickedUp:
		position = get_global_mouse_position() - Vector2(113/2, 40/2)

func _on_gui_input(event: InputEvent) -> void:
	if !(event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT):
		return
	if (pickedUp):
		secretManager.clearSelected()
		pickedUp = false
		scale = Vector2(1.5, 1.5)
		position = savedLocation
		z_index = 0
		return
	if (!pickedUp && !secretManager.selectedAnswer):
		savedLocation = position
		scale = Vector2(1, 1)
		z_index = 1
		pickedUp = true
		secretManager.setSelected(self, answer)
