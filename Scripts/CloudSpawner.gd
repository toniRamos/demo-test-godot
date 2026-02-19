class_name CloudSpawner
extends Node

## Componente reutilizable para generar nubes automáticamente

@export_group("Cloud Settings")
@export var cloud_scene: PackedScene

@export_group("Spawn Position")
@export var spawn_x: float = 1300.0
@export var min_y: float = 0.0
@export var max_y: float = 480.0

@export_group("Timing")
@export var min_interval: float = 0.35
@export var max_interval: float = 3.0
@export var auto_start: bool = true

var _timer: Timer

func _ready() -> void:
	# Crear timer interno
	_timer = Timer.new()
	_timer.one_shot = true
	_timer.timeout.connect(_spawn_cloud)
	add_child(_timer)
	
	if auto_start:
		_restart_timer()

func _spawn_cloud() -> void:
	if cloud_scene:
		var cloud = cloud_scene.instantiate()
		cloud.position = Vector2(spawn_x, randf_range(min_y, max_y))
		get_parent().add_child(cloud)
	
	_restart_timer()

func _restart_timer() -> void:
	_timer.wait_time = randf_range(min_interval, max_interval)
	_timer.start()

func stop() -> void:
	if _timer:
		_timer.stop()

func _exit_tree() -> void:
	stop()
