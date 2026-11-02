extends ColorRect

@export var upgradeNumber: int
@export var basePrice: int
@export var maxPurchase: int = 0 # 0 means no limit
@onready var nameLabel = $Name
@onready var buyButton = $Button
var price: int
var purchaseAmount: int = 0

func _ready() -> void:
	price = basePrice
	nameLabel.text = nameLabel.text.replace("COST", str(price))
	
func _process(delta: float) -> void:
	if (maxPurchase != 0 && purchaseAmount == maxPurchase):
		buyButton.disabled = true
		return
	var mainController = get_parent().get_parent().get_parent().get_parent()
	var currentCoinCount = mainController.coinCount
	if (price > currentCoinCount):
		buyButton.disabled = true
	else:
		buyButton.disabled = false

func _on_button_pressed() -> void:
	var mainController = get_parent().get_parent().get_parent().get_parent()
	var purchased = mainController.handleBuyUpgrade(upgradeNumber, price)
	if (purchased):
		purchaseAmount += 1
		var oldPrice = price
		price = floor(basePrice * (1.3 ** purchaseAmount))
		nameLabel.text = nameLabel.text.replace(str(oldPrice), str(price))
		if (purchaseAmount == maxPurchase):
			buyButton.text = "MAXED"
