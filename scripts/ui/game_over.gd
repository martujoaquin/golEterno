extends Control

func _ready():
	visible = false #arranca oculto
	
func show_game_over():
	visible = true
	
func _on_button_pressed() -> void:
	get_tree().paused = false  # por si estaba en pausa
	get_tree().reload_current_scene()
