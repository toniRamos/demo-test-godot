extends Node2D

@onready var tralaleros_timer = $SpawnTralaleros
@onready var player = $Player
@onready var jump_label = $CanvasLayer/Counter
@onready var kill_label = $CanvasLayer/KillCounter

@export var shark_scene: PackedScene  # Arrastrás aquí el SharkEnemy.tscn en el editor

func _ready():
	# Conectar señales del jugador con la UI
	if player:
		player.jump_performed.connect(_on_player_jump)
		player.enemy_killed.connect(_on_enemy_killed)

func _process(_delta):
	# Detectar Escape para volver al menú principal
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _exit_tree():
	# Limpiar recursos al salir de la escena
	if tralaleros_timer:
		tralaleros_timer.stop()

func _on_player_jump(jump_count: int) -> void:
	if jump_label:
		jump_label.text = "Saltos: %d" % jump_count

func _on_enemy_killed(kill_count: int) -> void:
	if kill_label:
		kill_label.text = "Muertes: %d" % kill_count

func _on_timer_timeout() -> void:
	var enemy = shark_scene.instantiate()
	enemy.position = Vector2(1300, 535)  # posición de aparición
	
	# Asignar velocidad aleatoria al tralalero
	var character_body = enemy.get_node("CharacterBody2D")
	if character_body:
		character_body.speed = randf_range(50.0, 150.0)
	
	add_child(enemy)
	tralaleros_timer.wait_time = randf_range(2, 8)
	tralaleros_timer.start()

