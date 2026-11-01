extends Node2D

var recipient = "POOBERT"
@onready var label = $Label

func setRecipient(name: String) -> void:
	recipient = name
	if (label):
		label.text = recipient

func _ready() -> void:
	label.text = recipient
