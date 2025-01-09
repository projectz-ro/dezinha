class_name DeathComponent
extends Node

@export var root: Node
@export var health: HealthComponent
@export var drops_item: bool
@export var time_before_death: float

var dead: bool = false
var pause: Timer = Timer.new()

func _ready() -> void:
	pause.wait_time = time_before_death
	add_child(pause)
	pause.connect("timeout", _on_pause_timeout)
	health.connect("health_changed", _on_health_changed)

func _process(delta: float) -> void:
	pass

func _on_health_changed(curr: int, max: int):
	if health.current_health <= 0:
		pause.start()

func _on_pause_timeout():
	# Pre death
	if drops_item:
		#do drop thing
		pass
	# TODO death effect
	root.queue_free()
