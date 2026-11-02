extends Node2D

var recipient = "POOBERT"
var canBePickedUp = true
var fontSizeOveride = false
var pickedUp = false
var savedPosition: Vector2
var savedScale: Vector2
@onready var label = $Label

func setRecipient(name: String, newCanBePickedUp: bool, newFontSizeOveride: bool = false) -> void:
	recipient = name
	canBePickedUp = newCanBePickedUp
	fontSizeOveride = newFontSizeOveride
	if (label):
		label.text = recipient
		if (fontSizeOveride):
			label.add_theme_font_size_override("font_size", 72)

func _ready() -> void:
	label.text = recipient
	if (fontSizeOveride):
		label.add_theme_font_size_override("font_size", 72)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !(event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT):
		return
	if (canBePickedUp and !pickedUp):
		savedPosition = position
		savedScale = scale
		pickedUp = true
		scale = Vector2(.11, .11)
		var manager = get_parent().get_parent()
		manager.setPickedUp(self)
	elif (canBePickedUp and pickedUp):
		pickedUp = false
		scale = savedScale
		position = savedPosition

func _process(delta: float) -> void:
	if pickedUp:
		position = get_global_mouse_position()
