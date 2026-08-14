extends Control

@onready var high_score = $HiScore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score.text = "Best Time: %.1fs" % GameState.best_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$PlayButton.play()
	get_tree().change_scene_to_file("res://main.tscn")
