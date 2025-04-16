extends Sprite2D

@export var speed: float = 50.0  # Velocidad personalizable desde el editor

func _process(delta: float) -> void:
	position.x -= speed * delta
	if position.x < -1600:  # Ajustá este valor según el tamaño de tu nube
		queue_free()
