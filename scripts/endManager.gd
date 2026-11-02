extends Node2D

@export var mainScene: PackedScene
@onready var fionaLetter = $Letters/Fiona
@onready var ratticusLetter = $Letters/Ratticus
@onready var blargLetter = $Letters/Blarg
@onready var miggyLetter = $Letters/Miggy
@onready var heidiLetter = $Letters/Heidi
@onready var oliveLetter = $Letters/Olive
@onready var nathanLetter = $Letters/Nathan
@onready var extra = $Extra
var lettersDelivered = 0

func setLettersDelivered(newLettersDelivered: int):
	lettersDelivered = newLettersDelivered

func _ready() -> void:
	fionaLetter.setRecipient("FIONA", false);
	ratticusLetter.setRecipient("RATTICUS", false);
	blargLetter.setRecipient("BLARG", false);
	miggyLetter.setRecipient("MIGGY", false);
	heidiLetter.setRecipient("HEIDI", false);
	oliveLetter.setRecipient("OLIVE", false);
	nathanLetter.setRecipient("MADE BY NATHAN", false, true);
	extra.text = extra.text.replace(str(0), str(lettersDelivered))

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(mainScene)
