extends Node

var max_score: int = 999999
var current_score: int = 0
signal score_updated(new_score: int)

var max_health: int = 5
var current_health: int = max_health
var dead = false
signal health_updated(new_health: int)

var current_memories: int = 0
var total_memories: int = 1
signal memories_updated(new_memories: int)

var letter_heading: String
var letter_body: String

var checkpointed: bool = false
var checkpoint_position: Vector2

func reload_from_checkpoint():
	if checkpointed:
		get_tree().get_first_node_in_group("Player").position = GameManager.checkpoint_position
		dead = false
		get_tree().get_first_node_in_group("Player").get_child(3).current_health = max_health
		add_health(10)
		health_updated.emit(10)
	else:
		get_tree().reload_current_scene()

## Add a negative for subtracting score
func add_score(amount: int):
	current_score += amount
	current_score = clamp(current_score, 0, max_score)
	emit_signal("score_updated", current_score)

func add_health(amount: int):
	current_health += amount
	current_health = clamp(current_health, 0, max_health)
	emit_signal("health_updated", current_health)
	
func add_memory(amount: int):
	current_memories += amount
	if current_memories < 0:
		current_memories = 0
	emit_signal("memories_updated", current_memories)
	
