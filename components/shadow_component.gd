class_name ShadowComponent
extends RayCast2D

@onready var shadow: Sprite2D = Sprite2D.new()

@export var shadow_texture: Texture2D = preload("res://sprites/shadow.png")
@export var width: float = 0.5

func _ready() -> void:
	add_child(shadow)  
	shadow.texture = shadow_texture
	shadow.modulate.a = 0.5
	shadow.z_index = 2
	shadow.visibility_layer = 1

func _process(delta: float) -> void:
	if is_colliding():
		shadow.visible = true
		var rayStart = global_position.y
		var distance = abs(get_collision_point().y - rayStart)
		var factor =(target_position.y - distance) / target_position.y
		shadow.offset.y = distance - 0.25
		shadow.scale = Vector2(factor * width, 1) 
	else:
		shadow.visible = false
