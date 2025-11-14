extends Node2D

func _ready() -> void:
	#pone el foco en el boton de cancha para seleccionarlo con el enter
	$canchas.grab_focus()
	$PelotaPica.play_animation("pica")
	$PelotaPica2.play_animation("pica")
	#$Baile.play_animation("baile")

func _on_canchas_pressed() -> void:
	#carga el nivel cancha
	get_tree().change_scene_to_file("res://scenes/main/lvl1-field.tscn")

func _on_ciudad_pressed() -> void:
	#carga el nivel ciudad
	get_tree().change_scene_to_file("res://scenes/main/lvl1-city.tscn")

func _on_exit_pressed() -> void:
	#cierro
	get_tree().quit()
