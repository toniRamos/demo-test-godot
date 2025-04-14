extends Sprite2D

var speed := 200  # velocidad en píxeles por segundo

func _process(delta):
	if Input.is_action_pressed("ui_left"):  # por defecto es la tecla A
		position.x -= speed * delta
		#scale.x = 1
	elif Input.is_action_pressed("ui_right"):  # por defecto es la tecla D
		position.x += speed * delta
		#scale.x = -1
		
	if Input.is_action_pressed("ui_up"):  # por defecto es la tecla A
		position.y -= speed * delta
	elif Input.is_action_pressed("ui_down"):  # por defecto es la tecla D
		position.y += speed * delta
