extends Area2D

var speed = 200

func _physics_process(delta):
	position.y += speed * delta
	# si se va de la pantalla, borrarlo
	if position.y > 700:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("¡Chocaste contra un obstáculo!")
		#body.queue_free()  # elimina al player (provisorio)
		#get_tree().reload_current_scene() #vuelve a arrancar directo
		
		#para que salga la pantalla game over:
		get_tree().paused = true
		var game_over_ui = get_tree().current_scene.get_node("GameOverUI")
		game_over_ui.show_game_over()
		
		
		#body.play_emote()  # activa el baile
		#await get_tree().create_timer(1.5).timeout  # deja bailar 1.5 seg

		var fixed_cam = get_tree().current_scene.get_node("CameraFija")
		fixed_cam.make_current()
		
