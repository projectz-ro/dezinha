extends AnimatedSprite2D

var speed = 25
var dir: int
var start_pos = Vector2()

func _ready():
	dir = get_parent().dir
	start_pos = global_position
	reparent(get_tree().root)

func _physics_process(delta: float) -> void:
	position.x += dir * speed * delta
	if abs(global_position.x - start_pos.x) > 100:
		queue_free()

func _on_hit_box_component_body_entered(body: Node2D) -> void:
	queue_free()
