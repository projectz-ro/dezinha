extends AudioStreamPlayer

@export var ui: UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui.hide_top()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
