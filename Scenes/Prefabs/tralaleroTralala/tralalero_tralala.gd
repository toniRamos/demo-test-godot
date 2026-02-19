extends CharacterBody2D

@export var speed: float = 100.0  # Velocidad configurable desde el editor
@export var explosion_duration: float = 0.5  # Duración del efecto de explosión

var is_dying: bool = false
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# Crear y aplicar shader material para el efecto de explosión
	var shader_material = ShaderMaterial.new()
	var shader = load("res://Shaders/explosion.gdshader")
	shader_material.shader = shader
	shader_material.set_shader_parameter("dissolve_amount", 0.0)
	shader_material.set_shader_parameter("explosion_color", Color(1.0, 0.3, 0.0, 1.0))  # Color naranja/fuego
	shader_material.set_shader_parameter("edge_thickness", 0.15)
	sprite.material = shader_material

func _physics_process(delta: float) -> void:
	if not is_dying:
		velocity.x = -speed  # Movimiento constante hacia la izquierda
		move_and_slide()

func explode() -> void:
	if is_dying:
		return
	
	is_dying = true
	velocity = Vector2.ZERO  # Detener movimiento
	
	# Animar la disolución
	var tween = create_tween()
	tween.tween_method(_update_dissolve, 0.0, 1.0, explosion_duration)
	tween.tween_callback(_on_explosion_finished)

func _update_dissolve(value: float) -> void:
	if sprite and sprite.material:
		sprite.material.set_shader_parameter("dissolve_amount", value)

func _on_explosion_finished() -> void:
	# Eliminar el nodo padre completo (TralaleroTralala)
	get_parent().queue_free()
