extends CharacterBody2D

## Script de movimiento y combate del jugador

# Contadores
var jump_counter := 0
var kill_counter := 0
var is_attacking: bool = false

@export_group("Movement")
@export var speed: float = 200.0
@export var jump_force: float = -600.0
@export var gravity: float = 900.0

@export_group("Animation Scales")
@export var scale_idle: Vector2 = Vector2(0.11, 0.11)
@export var scale_walk: Vector2 = Vector2(0.26, 0.26)
@export var scale_attack: Vector2 = Vector2(0.11, 0.11)

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bate: Area2D = $Bate
@onready var label_PAM: Label = $Bate/Label

# Señales para desacoplar UI
signal jump_performed(jump_count: int)
signal enemy_killed(kill_count: int)

func _ready():
	# Conectar señal del bate para detectar colisiones
	if bate:
		bate.body_entered.connect(_on_bate_body_entered)
		bate.monitoring = false  # Desactivar detección hasta que ataque
	else:
		push_error("Bate node not found!")


func _physics_process(delta):
	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	# Movimiento horizontal
	velocity.x = direction * speed

	if Input.is_action_just_pressed("ui_accept"):
		is_attacking = true
		anim_sprite.scale = scale_attack
		anim_sprite.play("attack")
		if bate:
			bate.monitoring = true  # Activar detección de colisiones del bate
		if label_PAM:
			label_PAM.text = "PAM!"

	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		# Salto solo si está en el suelo
		if Input.is_action_just_pressed("ui_up"):  # Por defecto, barra espaciadora
			velocity.y = jump_force
			jump_counter += 1
			update_jump_counter()

	# Flip del sprite y gestión de animaciones
	if direction != 0:
		$Sprite2D.flip_h = direction > 0
		anim_sprite.flip_h = direction > 0
		if not is_attacking and is_on_floor():
			if anim_sprite.animation != "walk":
				anim_sprite.scale = scale_walk
				anim_sprite.play("walk")
	else:
		if not is_attacking and is_on_floor():
			if anim_sprite.animation != "stay":
				anim_sprite.scale = scale_idle
				anim_sprite.play("stay")

	move_and_slide()
	
func update_jump_counter():
	jump_performed.emit(jump_counter)

func update_kill_counter():
	enemy_killed.emit(kill_counter)

func _on_bate_body_entered(body: Node2D) -> void:
	# Verificar si es un tralalero y activar explosión
	if body.is_in_group("enemy") or body.name == "CharacterBody2D":
		# Llamar a la función explode del enemigo
		if body.has_method("explode"):
			body.explode()
			kill_counter += 1
			update_kill_counter()

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "attack":
		is_attacking = false
		if bate:
			bate.monitoring = false  # Desactivar detección del bate
		if label_PAM:
			label_PAM.text = ""
		anim_sprite.scale = scale_idle
		anim_sprite.play("stay")
