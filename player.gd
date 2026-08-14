extends Area2D

@export var speed := 300.0

var min_x: float
var max_x: float

signal died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var half_width := 20.0
	min_x = half_width
	max_x = get_viewport_rect().size.x - half_width



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	position.x += direction * speed * delta
	position.x = clamp(position.x, min_x, max_x)


func _on_area_entered(_area: Area2D) -> void:
	died.emit()
	set_process(false)
