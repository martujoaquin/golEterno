extends CharacterBody2D

var speed = 0
var lane_x = 0  # -1 = izquierda, 0 = centro, 1 = derecha
var lanes = [200.0, 300.0, 400.0]  # posiciones X de carriles (ajustá según tu escena)

func _ready():
	# arranca en el carril del medio
	#para que corra
	$AnimatedSprite2D.play("run")  # nombre de la animación
	position = Vector2(lanes[1], 350)  # arranca en el carril del medio

func _physics_process(delta):
	# movimiento automático hacia arriba
	position.y -= speed * delta

	# moverse suavemente al carril elegido
	var target_x = lanes[lane_x + 1]
	position.x = lerp(position.x, target_x, 0.1)

func _input(event):
	if event.is_action_pressed("ui_left") and lane_x > -1:
		lane_x -= 1
	elif event.is_action_pressed("ui_right") and lane_x < 1:
		lane_x += 1
