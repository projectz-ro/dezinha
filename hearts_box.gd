extends HBoxContainer

@export var full_heart_texture: Texture
@export var empty_heart_texture: Texture

func _ready() -> void:
	GameManager.connect("health_updated", _on_health_updated)
	for i in range(GameManager.max_health):
		var heart = TextureRect.new()
		heart.texture = full_heart_texture
		heart.stretch_mode = TextureRect.STRETCH_SCALE
		heart.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		add_child(heart)

func _on_health_updated(newHealth: int)->void:
	for i in range(GameManager.max_health):
		var heart = get_child(i) as TextureRect
		if i < newHealth:
			heart.texture = full_heart_texture
		else:
			heart.texture = empty_heart_texture
