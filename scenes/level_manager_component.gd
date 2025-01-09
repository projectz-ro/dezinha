class_name LevelManagerComponent
extends Node

var score: int
var score_display: Control

var pics_current: int
var pics_current_display: Label
var pics_total: int
var pics_total_display: Label

signal pics_updated(new_health: int)
signal score_updated(new_score: int)

func _ready() -> void:
	score = 0
	pics_current = 0
	pics_current_display = get_node("UI").pics_current_display
	pics_current_display.text = str(0)
	pics_total = get_node("Pictures").get_child_count()
	pics_total_display = get_node("UI").pics_total_display
	pics_total_display.text = str(pics_total)

func score_up(amount: int):
	score += amount
	emit_signal("score_updated", score)

func score_down(amount: int):
	score -= amount
	emit_signal("score_updated", score)

func pic_found():
	pics_current += 1
	pics_current_display.text = str(pics_current)
	emit_signal("score_updated", score)
