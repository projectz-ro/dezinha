class_name UI
extends Node

@export var full_heart_texture: Texture   
@export var empty_heart_texture: Texture 
@export var player: Node                 

@onready var heart_container = $CanvasLayer/Control/Top/VBoxContainer/HBoxContainer/HeartsBox
@onready var score_value: Label = $CanvasLayer/Control/Top/VBoxContainer/HBoxContainer/ScoreBox/ScoreValue
@onready var delay: Timer = $score_delay
@onready var pics_current_display = $CanvasLayer/Control/Top/VBoxContainer/HBoxContainer/PictureCount/PictureNumbers/Current
@onready var pics_total_display = $CanvasLayer/Control/Top/VBoxContainer/HBoxContainer/PictureCount/PictureNumbers/Total
@onready var letter: TextureRect = $CanvasLayer/Control/Main/Letter
@onready var letter_text: Label = $CanvasLayer/Control/Main/Letter/ScrollContainer/LetterText
@onready var letter_heading: Label = $CanvasLayer/Control/Main/Letter/LetterHeading
@onready var scroll_container: ScrollContainer = $CanvasLayer/Control/Main/Letter/ScrollContainer

var player_health: HealthComponent 
@export var memories: Node
var display_score: int = 0
var count: bool = false
var is_time: bool = false

func _ready() -> void:
	GameManager.connect("score_updated", _on_score_updated)
	GameManager.connect("memories_updated", _on_memories_updated)
	var children = player.get_children()
	for c in children:
		if c is HealthComponent:
			player_health = c
			break
	player_health.connect("health_changed", _on_health_updated)
	
	_setup_hearts()
	pics_total_display.text = str(memories.get_child_count())

func _setup_hearts() -> void:
	for i in range(GameManager.max_health):
		var heart = TextureRect.new()
		heart.texture = full_heart_texture
		heart.stretch_mode = TextureRect.STRETCH_SCALE
		heart.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		heart_container.add_child(heart)

func _process(delta: float) -> void:
	if count and is_time:
		_update_score_display()
	
	if Input.is_action_just_pressed("pause"):
		if not get_tree().paused:
			get_tree().paused = true
			show_letter("Paused", "P = Pause,\nC = Camera,\nLeft Shift = Shoot")
		else:
			hide_letter()
			get_tree().paused = false
	#if GameManager.dead:
		#letter.visible = true
		#letter_heading.text = "You Died"
		#letter_text.text = "So sorry...\nTry again..."

func _update_score_display() -> void:
	var current_score = GameManager.current_score
	if current_score == display_score:
		count = false
		score_value.text = str(current_score)
		delay.stop()
	else:
		display_score += 1 if current_score > display_score else -1
		score_value.text = str(display_score)
		delay.start()
		is_time = false

func _on_memories_updated(new_current: int):
	pics_current_display.text = str(new_current) 

func _on_delay_timeout() -> void:
	is_time = true
	delay.stop()

func _on_health_updated(new_current: int, new_max: int) -> void:
	for i in range(new_max):
		var heart = heart_container.get_child(i) as TextureRect
		heart.texture = full_heart_texture if i < new_current else empty_heart_texture

func _on_score_updated(new_score: int) -> void:
	count = true
	is_time = true

func show_letter(heading: String, body: String):
	letter_heading.text = heading
	letter_text.text = body
	scroll_container.scroll_vertical=0
	letter.visible = true

func hide_letter():
	letter.visible = false
