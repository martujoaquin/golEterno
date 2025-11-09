extends Area2D
class_name ObstacleBase

@export var speed: float = 140.0  # arrancamos tranqui
@export var despawn_y: float = 900.0  # cuando sale de la pantalla
var lane_idx: int = -1 

func _ready() -> void:
	add_to_group("obstacles")

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	if global_position.y > despawn_y:
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

		#var fixed_cam = get_tree().current_scene.get_node("CameraFija")
		#fixed_cam.make_current()
		
