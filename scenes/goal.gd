extends Node2D

@export var ui: UI
@export var mem_heading: String
@export_multiline var mem_body: String
@export var next_level: PackedScene
@onready var black_anim: AnimationPlayer = $BlackAnim
@onready var black: Sprite2D = $Black
@onready var wait: Timer = $Wait

var reading: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	black.visible = true
	black_anim.play("fade_out")
	GameManager.add_memory(88)

func _process(delta: float) -> void:
	if reading and !ui.letter.visible and wait.is_stopped():
		get_tree().change_scene_to_packed(next_level)

func _on_area_2d_area_entered(area: Area2D) -> void:
	$AudioStreamPlayer.play(0)
	black_anim.play("fade_in")
	wait.start()

func _on_wait_timeout() -> void:
	wait.stop()
	if GameManager.current_memories == GameManager.total_memories:
		ui.show_letter(mem_heading,mem_body)
		get_tree().paused = true
		reading = true
		var asp = get_parent().get_child(0) as AudioStreamPlayer
		asp.stream = load("res://sounds/memory-reading.mp3")
		asp.play(0)
	else:
		get_tree().change_scene_to_packed(next_level)
