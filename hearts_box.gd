class_name UI
extends Node

@export var full_heart_texture: Texture
@export var empty_heart_texture: Texture
@export var player: Node
@onready var heart_container = $CanvasLayer/Control/Top/VBoxContainer/HBoxContainer/HeartsBox
var player_health: HealthComponent 

func _ready() -> void:
	var children = player.get_children()
	for c in children:
		if c is HealthComponent:
			player_health = c
			break
	player_health.connect("health_changed", _on_health_updated)
	for i in range(GameManager.max_health):
		var heart = TextureRect.new()
		heart.texture = full_heart_texture
		heart.stretch_mode = TextureRect.STRETCH_SCALE
		heart.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		heart_container.add_child(heart)

func _on_health_updated(new_current: int, new_max: int)->void:
	for i in range(new_max):
		var heart = heart_container.get_child(i) as TextureRect
		if i < new_current:
			heart.texture = full_heart_texture
		else:
			heart.texture = empty_heart_texture
