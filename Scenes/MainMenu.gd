extends Control

func _ready() -> void:
	# Conectar la señal del botón New Game
	$UI/CenterContainer/VBoxContainer/NewGameButton.pressed.connect(_on_new_game_pressed)
	# Conectar la señal del botón Quit
	$UI/CenterContainer/VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)

func _on_new_game_pressed() -> void:
	# Cargar la escena principal del juego
	get_tree().change_scene_to_file("res://Scenes/principal.tscn")

func _on_quit_pressed() -> void:
	# Salir del juego
	get_tree().quit()

