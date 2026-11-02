extends Node2D

var selectedAnswer: ColorRect
var selectedAnswerValue: String
var selectedObject: ColorRect
var selectedObjectAnswer: String
var matchCount: int = 0
@onready var win = $Win

func checkAnswer(correctAnswer) -> void:
	if !(selectedAnswer && selectedAnswerValue):
		return

func setSelected(answer: ColorRect, answerValue: String) -> void:
	selectedAnswer = answer
	selectedAnswerValue = answerValue

func clearSelected() -> void:
	if (selectedAnswerValue == selectedObjectAnswer && selectedAnswerValue != ""):
		selectedObject.setAnswered()
		selectedAnswer.queue_free()
		matchCount += 1
		if (matchCount == 8):
			win.visible = true
	selectedAnswer = null
	selectedAnswerValue = ""

func setSelectedObject(object: ColorRect, objectAnswer: String) -> void:
	selectedObject = object
	selectedObjectAnswer = objectAnswer

func clearSelectedObject() -> void:
	selectedObject = null
	selectedObjectAnswer = ""

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start.tscn")
