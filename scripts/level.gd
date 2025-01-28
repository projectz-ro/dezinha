extends Node2D

@export var ui: UI
@export var intro_heading: String
@export_multiline var intro_body: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.current_health = GameManager.max_health
	GameManager.add_memory(-100)
	GameManager.current_memories = 0
	
	GameManager.checkpointed = false
	get_tree().paused = true
	ui.show_letter(intro_heading, intro_body)
