extends Area2D

@export var speed := 300.0

var min_x: float
var max_x: float
var is_touching := false
var touch_target_x := 0.0

signal died

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		is_touching  = event.pressed
		touch_target_x = event.position.x
		print(event)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var half_width := 20.0
	min_x = half_width
	max_x = get_viewport_rect().size.x - half_width


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_touching:
		position.x = move_toward(position.x, touch_target_x, speed * delta)
	else:
		var direction := Input.get_axis("move_left", "move_right")
		position.x += direction * speed * delta
		position.x = clamp(position.x, min_x, max_x)

func _on_area_entered(_area: Area2D) -> void:
	died.emit()
	$GameOver.play()
	set_process(false)
	
