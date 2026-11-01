extends Node2D

const names = ["POOBERT", "RATTICUS", "HEIDI", "BLARG", "OLIVE", "FIONA", "MIGGY"]
@export var letterScene: PackedScene
var coinCount: int = 0
var lettersInQueue: Array[Node2D] = []
var maxLettersInQueue: int = 2
var timeUntilSpawnLetter = 5
@onready var coinCountLabel = $CoinCount
@onready var letterQueue = $LetterQueue
@onready var queueCountLabel = $LetterQueue/QueueCount

func updateCoinCount(newCoinCount: int) -> void:
	coinCount = newCoinCount
	coinCountLabel.text = str(coinCount)

func spawnLetter() -> Node2D:
	var recipient = names[randi_range(0, 6)]
	var letter = letterScene.instantiate()
	letterQueue.add_child(letter)
	letter.setRecipient(recipient)
	letter.z_index = maxLettersInQueue - lettersInQueue.size()
	letter.position = Vector2(-30-100*lettersInQueue.size(), 250)
	return letter

func handleSpawnLetter() -> void:
	if (maxLettersInQueue == lettersInQueue.size()):
		print("YOU LOSE")
		return
	var letter = spawnLetter()
	lettersInQueue.append(letter)
	queueCountLabel.text = "%d/%d" % [lettersInQueue.size(), maxLettersInQueue]

func _ready() -> void:
	updateCoinCount(500)
	handleSpawnLetter()
	handleSpawnLetter()
	handleSpawnLetter()
