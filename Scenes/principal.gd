extends Node2D

@onready var cloud_timer = $SpawnClouds

@export var shark_scene: PackedScene  # Arrastrás aquí el SharkEnemy.tscn en el editor
@export var clouds_sprite2D: PackedScene

func _on_timer_timeout() -> void:
	var enemy = shark_scene.instantiate()
	enemy.position = Vector2(1300, 515)  # posición de aparición
	add_child(enemy)


func _ready():
	set_random_timer()

func _on_CloudTimer_timeout():
	var clouds = clouds_sprite2D.instantiate()
	clouds.position = Vector2(1300, randf_range(0, 600))    # posición de aparición
	add_child(clouds)
	set_random_timer()

func set_random_timer():
	cloud_timer.wait_time = randf_range(2.0, 5.0)  # entre 2 y 5 segundos
	cloud_timer.start()
