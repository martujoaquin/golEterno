extends Node2D

func _ready():
	
	GLOBAL.jugador = $Player
	GLOBAL.juego_terminado = false
	GLOBAL.puntaje = 0
	GLOBAL.nivel_dificultad = 0


func aumenta_puntaje():
	GLOBAL.puntaje += 1 + int(GLOBAL.nivel_dificultad * 0.5)
	$UI/Puntos.text = "puntos: " + str(GLOBAL.puntaje)


#func _on_timer_difi_timeout():	
#	$Spawner.aumenta_dificultad()


func juego_terminado():
	
	GLOBAL.juego_terminado = true
	$UI/GameOver.visible = true
	await get_tree().create_timer(5).timeout
	#get_tree().change_scene_to_file("res://escenas/menu.tscn")

func _on_puntaje_timer_timeout() -> void:
	aumenta_puntaje()
