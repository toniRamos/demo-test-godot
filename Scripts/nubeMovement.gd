extends Sprite2D

# Rangos de velocidad horizontal
@export var min_speed: float = 30.0
@export var max_speed: float = 80.0

# Rangos de ondulación vertical (frecuencia y amplitud)
@export var min_frequency: float = 0.3
@export var max_frequency: float = 1.2
@export var min_amplitude: float = 5.0
@export var max_amplitude: float = 20.0

# Rangos de escala para simular profundidad
@export var min_scale: float = 0.15
@export var max_scale: float = 0.4

# Variables únicas para cada instancia de nube
var speed: float
var frequency: float
var amplitude: float
var phase: float
var base_y: float
var time: float = 0.0

func _ready() -> void:
	# Generar valores aleatorios únicos para esta nube
	speed = randf_range(min_speed, max_speed)
	frequency = randf_range(min_frequency, max_frequency)
	amplitude = randf_range(min_amplitude, max_amplitude)
	phase = randf_range(0.0, TAU)  # Fase inicial aleatoria (0 a 2π)
	
	# Guardar posición Y base (spawn position)
	base_y = position.y
	
	# Asignar escala aleatoria (nubes más pequeñas = más lejanas = más lentas)
	var random_scale = randf_range(min_scale, max_scale)
	scale = Vector2(random_scale, random_scale)
	
	# Correlacionar velocidad con escala: nubes más pequeñas van más lento
	speed *= (random_scale / max_scale)

func _process(delta: float) -> void:
	# Acumular tiempo para la ondulación
	time += delta
	
	# Movimiento horizontal (constante hacia la izquierda)
	position.x -= speed * delta
	
	# Movimiento vertical ondulatorio (seno)
	position.y = base_y + sin(time * frequency + phase) * amplitude
	
	# Eliminar nube cuando sale completamente de pantalla
	if position.x < -1600:
		queue_free()
