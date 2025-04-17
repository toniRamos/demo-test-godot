extends Sprite2D

@export var start_pos: Vector2 = Vector2(-200, 200)
@export var end_pos: Vector2 = Vector2(1400, 200)
@export var speed: float = 100.0
@export var frequency: float = 2.0
@export var amplitude: float = 30.0
@onready var shader_mat := material as ShaderMaterial
var last_pos := global_position

var t: float = 0.0
var direction: int = 1

func _ready():
	position = start_pos
	flip_h = direction < 0
	queue_redraw()

func _process(delta: float) -> void:
	#Shader funcionality
	var velocity := global_position - last_pos

	last_pos = global_position
	
	t += delta * direction
	var total_distance: float = start_pos.distance_to(end_pos)
	var progress: float = clamp(t * speed / total_distance, 0.0, 1.0)

	var x: float = lerp(start_pos.x, end_pos.x, progress)
	var y: float = lerp(start_pos.y, end_pos.y, progress) + sin(t * frequency) * amplitude

	position = Vector2(x, y)

	# Cambiar de dirección y actualizar flip inmediatamente
	if progress >= 1.0 or progress <= 0.0:
		direction *= -1
		flip_h = direction < 0
