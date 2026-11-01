extends Node2D

var recipient = "POOBERT"
@onready var label = $Label

func setRecipient(name: String) -> void:
	recipient = name
	label.text = recipient
