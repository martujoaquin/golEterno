extends Node2D

@onready var objetivo_label: Label = $UI/ObjetivoLabel
@onready var objetivo_completado: Label = $UI/ObjetivoCompletado

var tiempo_objetivo: float = 20.0
var tiempo_actual: float = 0.0
var objetivo_ya_cumplido: bool = false
var nivel_actual: int = 1

func _ready():
	GLOBAL.jugador = $Player
	#GLOBAL.jugador = $Player
	GLOBAL.juego_terminado = false
	GLOBAL.puntaje = 0
	GLOBAL.nivel_dificultad = 0
	GLOBAL.tiempo = 0
	GLOBAL.medallas = 0
	objetivo_label.text = "NIVEL 1: Llegar a 20 segundos"
	objetivo_completado.visible = false


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

func _process(delta:float) -> void:
	_actualizar_objetivos(delta)

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

func _actualizar_objetivos(delta: float) -> void:
	if GLOBAL.juego_terminado:
		return
	
	tiempo_actual += delta
	
	#nivel 1 -> llegar a 20 seg
	if nivel_actual == 1:
		if objetivo_ya_cumplido == false:
			if tiempo_actual >= 20.0:
				objetivo_ya_cumplido = true
				_mostrar_cartel_objetivo_completado()
				objetivo_label.text = "" 
		return
	
	#nivel 2 -> 3 medallas
	if nivel_actual == 2:
		if GLOBAL.medallas >= 3 and objetivo_ya_cumplido == false:
			objetivo_ya_cumplido = true
			_mostrar_cartel_objetivo_completado()
			objetivo_label.text = ""
		return
		
	#nivel 3 -> llegar a 50 seg
	if nivel_actual == 3:
		if objetivo_ya_cumplido == false:
			if tiempo_actual >= 50.0:
				objetivo_ya_cumplido = true
				_mostrar_cartel_objetivo_completado()
				objetivo_label.text = ""
			return
	
	#nivel 4 -> llegar a 180 puntos
	if nivel_actual == 4:
		if objetivo_ya_cumplido == false and GLOBAL.puntaje >= 180:
				objetivo_ya_cumplido = true
				objetivo_label.text = ""
				_mostrar_cartel_objetivo_completado()
		return
			
	
func _mostrar_cartel_objetivo_completado() -> void:
	objetivo_completado.text = "NIVEL COMPLETADO"
	objetivo_completado.visible = true
	
	await get_tree().create_timer(2.0).timeout
	objetivo_completado.visible = false
	
	#nuevo nivel
	nivel_actual += 1
	objetivo_ya_cumplido = false
	
	match nivel_actual:
		2:
			objetivo_label.text = "NIVEL 2: Recolectar 3 medallas"
		3: 
			objetivo_label.text = "NIVEL 3: Llegar a 50 segundos"
		4:
			objetivo_label.text = "NIVEL 4: Hacer 180 puntos"
		5:
			objetivo_label.text = "TODOS LOS OBJETIVOS COMPLETADOS"
			# si querés, dejamos bloqueado:
			objetivo_ya_cumplido = true
		_:
			objetivo_label.text = ""
		
