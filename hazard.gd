extends Area2D

@export var fall_speed := 300.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += fall_speed * delta
	if position.y > get_viewport_rect().size.y:
		queue_free()
		
