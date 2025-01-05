extends Sprite2D

@onready var ray: RayCast2D = $"../RayCast2D"
@export var caster: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body. 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if ray.is_colliding():
		var distance = ray.position.y - ray.get_collision_point().y
		position.y = abs(distance)
		var factor =(ray.target_position.y - distance) / ray.target_position.y
		scale = Vector2(factor, 1) 
		print(floor(distance))
