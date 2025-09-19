extends Control

func _ready():
	visible = false #arranca oculto
	
func enter(character):
	#reproducir animacion baile
	character.play_animation("emote")

func show_game_over():
	visible = true
	
func _on_button_pressed() -> void:
	get_tree().paused = false  # 1. aseguramos que se despause
	await get_tree().process_frame  # 2. esperamos un frame
	get_tree().reload_current_scene()  # 3. recargamos
