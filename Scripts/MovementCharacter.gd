extends CharacterBody2D

# Variables de movimiento
var speed := 200
var jump_force := -400
var gravity := 900

func _physics_process(delta):
	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	# Movimiento horizontal
	velocity.x = direction * speed

	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Salto solo si está en el suelo
		if Input.is_action_just_pressed("ui_accept"):  # Por defecto, barra espaciadora
			velocity.y = jump_force

	# Flip del sprite
	if direction != 0:
		$Sprite2D.flip_h = direction > 0

	move_and_slide()
