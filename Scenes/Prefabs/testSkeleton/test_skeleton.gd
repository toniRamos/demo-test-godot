extends Node2D

@onready var bone_cabeza = $Skeleton2D/BoneCabeza
@onready var anim_tree = $AnimationTree
@onready var state_machine = anim_tree.get("parameters/playback")
var velocity = Vector2.ZERO

func _ready():
	anim_tree.active = true
	$AnimationTree.active = true

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = 100
		scale.x = 1
		state_machine.travel("walk") 
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -100
		scale.x = -1
		state_machine.travel("walk")
	else:
		velocity.x = 0
		state_machine.travel("idle") 

	position += velocity * delta

	if Input.is_action_just_pressed("ui_up"):
		mirar_arriba(true)
	elif Input.is_action_just_released("ui_up"):
		mirar_arriba(false)

func mirar_arriba(activar: bool):
	if activar:
		bone_cabeza.rotation_degrees = -30
	else:
		bone_cabeza.rotation_degrees = 0
