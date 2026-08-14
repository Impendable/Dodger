extends Node2D

@onready var player = $Player

const HAZARD_SCENE := preload("res://hazard.tscn")

var min_x: float
var max_x: float
var upper_spawn := -20.0
var max_speed := 500.0
var current_fall_speed := 300.0
var is_game_over := false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hazard_half_width := 8.0
	min_x = hazard_half_width
	max_x = get_viewport_rect().size.x - hazard_half_width
	
	player.died.connect(game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var hazard = HAZARD_SCENE.instantiate()
	hazard.position = Vector2(randf_range(min_x, max_x), upper_spawn)
	current_fall_speed = min(current_fall_speed + 8, max_speed)
	hazard.fall_speed = current_fall_speed
	add_child(hazard)
	$Timer.wait_time = max(0.25, $Timer.wait_time -0.02)
	
func game_over():
	$Timer.stop()
	$CanvasLayer/Label.show()
	is_game_over = true
	
func _unhandled_input(event: InputEvent) -> void:
	if not is_game_over:
		return
	if event.is_action_pressed("Restart"):
		restart_game()

func restart_game():
	get_tree().reload_current_scene()
