extends Node2D

const names = ["POOBERT", "RATTICUS", "HEIDI", "BLARG", "OLIVE", "FIONA", "MIGGY"]
@export var letterScene: PackedScene
var coinCount: int = 0
var lettersInQueue: Array[Node2D] = []
var maxLettersInQueue: int = 2
var timeUntilSpawnLetter = 5
var pickedUpLetter: Node2D
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
		print("YOU LOSE")
		return
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

func _ready() -> void:
	updateCoinCount(500)

func _on_timer_timeout() -> void:
	if (timeUntilSpawnLetter > 1):
		timeUntilSpawnLetter -= 1
		nextLetterInLabel.text = "NEXT LETTER IN %d SECONDS" % timeUntilSpawnLetter
		return
	handleSpawnLetter()
	timeUntilSpawnLetter = 5
	nextLetterInLabel.text = "NEXT LETTER IN %d SECONDS" % timeUntilSpawnLetter

func setPickedUp(letter: Node2D) -> void:
	pickedUpLetter = letter

func clickedMailbox(mailboxOwner: String) -> void:
	if (pickedUpLetter && pickedUpLetter.recipient == mailboxOwner):
		lettersInQueue.erase(pickedUpLetter)
		pickedUpLetter.queue_free()
		handleRepositionLetters()
		updateCoinCount(coinCount + 50)
