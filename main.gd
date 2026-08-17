extends Node2D

@onready var player = $Player
@onready var score = $UI/Score
@onready var game_over_label = $UI/GameOver
@onready var new_record = $UI/NewRecord
@onready var restart_button = $UI/RestartButton


const HAZARD_SCENE := preload("res://hazard.tscn")

var time_survived: float
var min_x: float
var max_x: float
var upper_spawn := -20.0
var max_speed := 900.0
var current_fall_speed := 300.0
var is_game_over := false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hazard_half_width := 8.0
	min_x = hazard_half_width
	max_x = get_viewport_rect().size.x - hazard_half_width
	Music.normal()
	player.died.connect(game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_game_over:
		
		time_survived += delta
		score.text = "Score: %d" % time_survived
		


func _on_timer_timeout() -> void:
	var hazard = HAZARD_SCENE.instantiate()
	hazard.position = Vector2(randf_range(min_x, max_x), upper_spawn)
	current_fall_speed = min(current_fall_speed + 8, max_speed)
	hazard.fall_speed = current_fall_speed
	add_child(hazard)
	$Timer.wait_time = max(0.12, $Timer.wait_time -0.02)

	
func game_over():
	$Timer.stop()
	var is_new_record := time_survived > GameState.best_time
	Music.duck()
	if is_new_record:
		$RecordSound.play()
		GameState.best_time = time_survived
		new_record.show()
	game_over_label.text = "GAME OVER - Press SPACE\nSurvived: %.1f\nBest: %.1f" % [time_survived, GameState.best_time]
	game_over_label.show()
	restart_button.show()
	is_game_over = true
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().change_scene_to_file("res://title.tscn")
		return
	if is_game_over and event.is_action_pressed("restart"):
		restart_game()
			

func restart_game():
	get_tree().reload_current_scene()
	

func _on_restart_button_pressed() -> void:
	if restart_button.visible:
		restart_game()


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://title.tscn")
