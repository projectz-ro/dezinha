extends Button
@onready var letter: TextureRect = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if GameManager.dead:
		get_tree().reload_current_scene()
	else:
		get_tree().paused = false
	letter.visible = false
