extends Label

var display_score: int = 0
var count: bool = false
var is_time: bool = false
@onready var delay: Timer = $delay

func _ready() -> void:
	GameManager.connect("score_updated", _on_score_updated)

func _process(delta: float) -> void:
	if count and is_time:
		if GameManager.current_score == display_score:
			count = false
			text = str(GameManager.current_score)
			delay.stop()
		else:
			if GameManager.current_score < display_score:
				display_score -= 1
			elif GameManager.current_score > display_score:
				display_score += 1
			text = str(display_score)
			delay.start()
			is_time = false

func _on_score_updated(new_score):
	count = true
	is_time = true

func _on_delay_timeout() ->void:
	is_time = true
