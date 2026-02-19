extends Control

@onready var cloud_timer = $Background/SpawnClouds
@export var clouds_sprite2D: PackedScene

func _ready() -> void:
	# Conectar la señal del botón New Game
	$UI/CenterContainer/VBoxContainer/NewGameButton.pressed.connect(_on_new_game_pressed)
	# Conectar la señal del botón Quit
	$UI/CenterContainer/VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)
	
	# Iniciar sistema de nubes
	set_random_timer()

func _on_new_game_pressed() -> void:
	# Cargar la escena principal del juego
	get_tree().change_scene_to_file("res://Scenes/principal.tscn")

func _on_quit_pressed() -> void:
	# Salir del juego
	get_tree().quit()

func _on_CloudTimer_timeout():
	if clouds_sprite2D:
		var clouds = clouds_sprite2D.instantiate()
		clouds.position = Vector2(1300, randf_range(0, 480))
		$Background.add_child(clouds)
	set_random_timer()

func set_random_timer():
	cloud_timer.wait_time = randf_range(0.35, 3)
	cloud_timer.start()
