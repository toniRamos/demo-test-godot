extends CharacterBody2D

@export var speed: float = 100.0  # Velocidad configurable desde el editor

func _physics_process(delta: float) -> void:
	velocity.x = -speed  # Movimiento constante hacia la izquierda
	move_and_slide()
