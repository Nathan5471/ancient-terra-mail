extends Node2D

const names = ["POOBERT", "RATTICUS", "HEIDI", "BLARG", "OLIVE", "FIONA", "MIGGY"]
@export var letterScene: PackedScene
@export var endScene: PackedScene
var coinCount: int = 0
var lettersInQueue: Array[Node2D] = []
var maxLettersInQueue: int = 2
var timeBetweenSpawns = 5
var timeUntilSpawnLetter = 5
var pickedUpLetter: Node2D
var letterValue = 10
var letterMultiplier = 1
var lettersDelivered = 0
@onready var coinCountLabel = $CoinCount
@onready var letterQueue = $LetterQueue
@onready var queueCountLabel = $LetterQueue/QueueCount
@onready var nextLetterInLabel = $LetterQueue/NextLetterTimer

func updateCoinCount(newCoinCount: int) -> void:
	coinCount = newCoinCount
	coinCountLabel.text = str(coinCount)

func spawnLetter() -> Node2D:
	var recipient = names[randi_range(0, 6)]
	var letter = letterScene.instantiate()
	letterQueue.add_child(letter)
	letter.setRecipient(recipient, lettersInQueue.size() == 0)
	letter.z_index = maxLettersInQueue - lettersInQueue.size()
	letter.position = Vector2(-30-100*lettersInQueue.size(), 230)
	return letter

func handleSpawnLetter() -> void:
	if (maxLettersInQueue == lettersInQueue.size()):
		handleLose()
	var letter = spawnLetter()
	lettersInQueue.append(letter)
	queueCountLabel.text = "%d/%d" % [lettersInQueue.size(), maxLettersInQueue]

func handleRepositionLetters() -> void:
	var i = 0
	for letter in lettersInQueue:
		letter.setRecipient(letter.recipient, i == 0)
		letter.z_index = maxLettersInQueue - i
		letter.position = Vector2(-30-100*i, 230)
	queueCountLabel.text = "%d/%d" % [lettersInQueue.size(), maxLettersInQueue]

func _on_timer_timeout() -> void:
	if (timeUntilSpawnLetter > 1):
		timeUntilSpawnLetter -= 1
		nextLetterInLabel.text = "NEXT LETTER IN %d SECONDS" % timeUntilSpawnLetter
		return
	handleSpawnLetter()
	timeUntilSpawnLetter = timeBetweenSpawns
	nextLetterInLabel.text = "NEXT LETTER IN %d SECONDS" % timeUntilSpawnLetter

func setPickedUp(letter: Node2D) -> void:
	pickedUpLetter = letter

func clickedMailbox(mailboxOwner: String) -> void:
	if (pickedUpLetter && pickedUpLetter.recipient == mailboxOwner):
		lettersInQueue.erase(pickedUpLetter)
		pickedUpLetter.queue_free()
		handleRepositionLetters()
		updateCoinCount(coinCount + letterValue * letterMultiplier)
		lettersDelivered += 1
	else:
		pickedUpLetter = null

func handleBuyUpgrade(upgradeNumber: int, upgradeCost: int) -> bool:
	if (upgradeCost > coinCount):
		return false
	updateCoinCount(coinCount - upgradeCost)
	if (upgradeNumber == 0):
		letterValue += 10
	elif (upgradeNumber == 1):
		timeBetweenSpawns -= 1
	elif (upgradeNumber == 2):
		maxLettersInQueue += 1
	elif (upgradeNumber == 3):
		letterValue += 50
	elif (upgradeNumber == 4):
		letterMultiplier *= 2
	return true

func handleLose() -> void:
	var endNode = endScene.instantiate()
	endNode.setLettersDelivered(lettersDelivered)
	get_tree().change_scene_to_node(endNode)
