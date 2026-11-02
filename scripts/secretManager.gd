extends Node2D

var selectedAnswer: ColorRect
var selectedAnswerValue: String
var selectedObject: ColorRect
var selectedObjectAnswer: String

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
	selectedAnswer = null
	selectedAnswerValue = ""

func setSelectedObject(object: ColorRect, objectAnswer: String) -> void:
	selectedObject = object
	selectedObjectAnswer = objectAnswer

func clearSelectedObject() -> void:
	selectedObject = null
	selectedObjectAnswer = ""
