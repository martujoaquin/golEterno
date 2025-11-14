extends Area2D
class_name Medalla

@export var speed: float = 140.0        # qué tan rápido baja
@export var despawn_y: float = 900.0    # y donde la borramos
#@export var value: int = 1              # cuántos puntos da la medalla

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if anim != null:
		anim.play("default") # o el nombre de tu animación

func _physics_process(delta: float) -> void:
	var dificultad = 1 + GLOBAL.nivel_dificultad * 0.15
	position.y += speed * delta * dificultad
	#global_position.y += speed * delta

	if global_position.y > despawn_y:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().current_scene.aumentar_medallas()
		queue_free()
