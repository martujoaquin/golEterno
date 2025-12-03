extends Node2D

func _ready():
	
	GLOBAL.jugador = $Player
	#GLOBAL.jugador = $Player
	GLOBAL.juego_terminado = false
	GLOBAL.puntaje = 0
	GLOBAL.nivel_dificultad = 0
	GLOBAL.tiempo = 0
	GLOBAL.medallas = 0


func aumenta_puntaje():
	GLOBAL.puntaje += 1 + int(GLOBAL.nivel_dificultad * 0.5)
	$UI/Puntos.text = str(GLOBAL.puntaje)
	#$UI/Puntos.text = "Puntos: " + str(GLOBAL.puntaje)

func aumentar_medallas():
	GLOBAL.medallas += 1
	$UI/Monedas.text = str(GLOBAL.medallas)
	print("Aumentar medallas, total: ", GLOBAL.medallas)

func imprime_tiempo():
	GLOBAL.tiempo += 1
	$UI/Tiempo.text = str(GLOBAL.tiempo, "s")


func _on_dificultad_timeout() -> void:
	GLOBAL.nivel_dificultad += min(GLOBAL.nivel_dificultad + 0.2, 10.0)
	print("Dificultad actual: ", GLOBAL.nivel_dificultad)
	var nuevo_min = clamp(2.5 - GLOBAL.nivel_dificultad * 0.18, 0.35, 2.5)
	var nuevo_max = clamp(3.5 - GLOBAL.nivel_dificultad * 0.18, 0.70, 3.5)
	$SpawnerCono.min_interval = nuevo_min
	$SpawnerCono.max_interval = nuevo_max
	$SpawnerPelota.min_interval = nuevo_min
	$SpawnerPelota.max_interval = nuevo_max


func juego_terminado():
	GLOBAL.juego_terminado = true
	$GameOver.visible = true
	await get_tree().create_timer(3).timeout
	#get_tree().change_scene_to_file("res://scenes/ui/Menu.tscn")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/Menu.tscn")
	
func _on_puntaje_timer_timeout() -> void:
	aumenta_puntaje()
	imprime_tiempo()
