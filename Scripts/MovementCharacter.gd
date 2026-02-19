extends CharacterBody2D

# Variables de movimiento
var speed := 200
var jump_force := -600
var gravity := 900
var jump_counter := 0
var is_attacking: bool = false

# Escalas para diferentes animaciones
var scale_stay := Vector2(0.11, 0.11)
var scale_walk := Vector2(0.26, 0.26)  # Walk necesita mayor escala porque los frames son más pequeños
var scale_attack := Vector2(0.11, 0.11)

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_label = get_node("/root/Main/CanvasLayer/Counter")
@onready var bate = get_node("/root/Main/Player/Bate")
@onready var label_PAM = get_node("/root/Main/Player/Bate/Label")


func _physics_process(delta):
	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	# Movimiento horizontal
	velocity.x = direction * speed

	if Input.is_action_just_pressed("ui_accept"):
		is_attacking = true
		anim_sprite.scale = scale_attack
		anim_sprite.play("attack")
		bate.disabled = false
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
				anim_sprite.scale = scale_stay
				anim_sprite.play("stay")

	move_and_slide()
	
func update_jump_counter():
	jump_label.text = "Saltos: %d" % jump_counter

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "attack":
		is_attacking = false
		bate.disabled = true
		label_PAM.text = ""
		anim_sprite.scale = scale_stay
		anim_sprite.play("stay")
