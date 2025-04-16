extends Node2D

@export var shark_scene: PackedScene  # Arrastrás aquí el SharkEnemy.tscn en el editor

func _on_timer_timeout() -> void:
	var enemy = shark_scene.instantiate()
	enemy.position = Vector2(1300, 515)  # posición de aparición
	add_child(enemy)
