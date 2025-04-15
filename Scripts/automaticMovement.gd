extends Node2D  # o Sprite2D si querés que sea visible

@export var start_pos: Vector2 = Vector2(100, 200)
@export var end_pos: Vector2 = Vector2(600, 200)
@export var speed: float = 100.0
@export var frequency: float = 2.0
@export var amplitude: float = 30.0

var t: float = 0.0
var direction: int = 1

func _ready():
	position = start_pos
	queue_redraw()

func _process(delta: float) -> void:
	t += delta * direction
	var total_distance: float = start_pos.distance_to(end_pos)
	var progress: float = clamp(t * speed / total_distance, 0.0, 1.0)

	var x: float = lerp(start_pos.x, end_pos.x, progress)
	var y: float = lerp(start_pos.y, end_pos.y, progress) + sin(t * frequency) * amplitude

	position = Vector2(x, y)

	if progress >= 1.0 or progress <= 0.0:
		direction *= -1

#func _draw():
	#draw_line(start_pos, end_pos, Color.LIME_GREEN, 2.0)
	#draw_circle(start_pos, 5.0, Color.RED)
	#draw_circle(end_pos, 5.0, Color.BLUE)

func _notification(what):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		queue_redraw()
