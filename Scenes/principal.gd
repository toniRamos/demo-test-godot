extends Node2D

@onready var cloud_timer = $SpawnClouds
@onready var tralaleros_timer = $SpawnTralaleros

@export var shark_scene: PackedScene  # Arrastrás aquí el SharkEnemy.tscn en el editor
@export var clouds_sprite2D: PackedScene

func _on_timer_timeout() -> void:
	var enemy = shark_scene.instantiate()
	enemy.position = Vector2(1300, 535)  # posición de aparición
	add_child(enemy)
	tralaleros_timer.wait_time = randf_range(2, 8)
	tralaleros_timer.start()


func _ready():
	set_random_timer()

func _on_CloudTimer_timeout():
	var clouds = clouds_sprite2D.instantiate()
	clouds.position = Vector2(1300, randf_range(0, 480))    # posición de aparición
	add_child(clouds)
	set_random_timer()

func set_random_timer():
	cloud_timer.wait_time = randf_range(0.35, 3)
	cloud_timer.start()
