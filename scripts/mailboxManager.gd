extends Area2D

@export_enum("POOBERT", "RATTICUS", "HEIDI", "BLARG", "OLIVE", "FIONA", "MIGGY") var mailboxOwner: String
var manager: Node2D

func _ready() -> void:
	manager = get_parent().get_parent()

func _on_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if !(event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT):
		return
	manager.clickedMailbox(mailboxOwner)
