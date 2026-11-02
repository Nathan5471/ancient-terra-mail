extends Node2D

var selectedAnswer: ColorRect
var selectedAnswerValue: String

func checkAnswer(correctAnswer) -> void:
	if !(selectedAnswer && selectedAnswerValue):
		return

func setSelected(answer: ColorRect, answerValue: String) -> void:
	selectedAnswer = answer
	selectedAnswerValue = answerValue

func clearSelected() -> void:
	selectedAnswer = null
	selectedAnswerValue = ""
