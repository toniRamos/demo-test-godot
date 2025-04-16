extends CharacterBody2D

# Variables de movimiento
var speed := 200
var jump_force := -600
var gravity := 900
var jump_counter := 0
var is_attacking: bool = false

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

	# Flip del sprite
	if direction != 0:
		$Sprite2D.flip_h = direction > 0

	move_and_slide()
	
func update_jump_counter():
	jump_label.text = "Saltos: %d" % jump_counter

func _on_animated_sprite_2d_animation_finished() -> void:
	if anim_sprite.animation == "attack":
		is_attacking = false
		bate.disabled = true
		label_PAM.text = ""
		anim_sprite.play("stay")
