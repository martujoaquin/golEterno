extends Area2D
class_name ObstacleBase

@export var speed: float = 140.0  # arrancamos tranqui
@export var despawn_y: float = 900.0  # cuando sale de la pantalla
var lane_idx: int = -1 

func _ready() -> void:
	add_to_group("obstacles")

func _physics_process(delta: float) -> void:
	var dificultad = 1 + GLOBAL.nivel_dificultad * 0.15
	position.y += speed * delta * dificultad
	if global_position.y > despawn_y:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("¡Chocaste contra un obstáculo!")
		get_tree().paused = true
		get_tree().get_current_scene().juego_terminado()
		
