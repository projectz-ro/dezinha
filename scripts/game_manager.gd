extends Node

var max_score: int = 999999
var current_score: int = 0
signal score_updated(new_score: int)

var max_health: int = 5
var current_health: int = max_health
signal health_updated(new_health: int)

#Add a negative for subtracting score
func add_score(amount: int):
	current_score += amount
	current_score = clamp(current_score, 0, max_score)
	emit_signal("score_updated", current_score)

func add_health(amount: int):
	current_health += amount
	current_health = clamp(current_health, 0, max_health)
	emit_signal("health_updated", current_health)
	
