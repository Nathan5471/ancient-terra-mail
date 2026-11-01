extends ColorRect

@export var upgradeNumber: int
@export var price: int
@onready var nameLabel = $Name
@onready var buyButton = $Button

func _ready() -> void:
	nameLabel.text = nameLabel.text.replace("COST", str(price))
	
func _process(delta: float) -> void:
	var mainController = get_parent().get_parent().get_parent().get_parent()
	var currentCoinCount = mainController.coinCount
	if (price > currentCoinCount):
		buyButton.disabled = true
	else:
		buyButton.disabled = false
