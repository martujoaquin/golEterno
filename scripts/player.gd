extends CharacterBody2D

var speed = 0
var lane_x = 0  # -1 = izquierda, 0 = centro, 1 = derecha
var lanes = [200.0, 300.0, 400.0]  # posiciones X de carriles (ajustá según tu escena)

var state_machine: StateMachine
var run_state: Run
var jump_state: Jump

func _ready():
	# arranca en el carril del medio
	position = Vector2(lanes[1], 350)  # arranca en el carril del medio
	
	#inicio la maquina de estados
	state_machine = StateMachine.new()
	run_state = Run.new()
	jump_state = Jump.new()
	
	#empezamos en run
	state_machine.change_state(run_state, self)
	
func _physics_process(delta):
	#position.y -= speed * delta
	state_machine.update(self, delta)

	# moverse suavemente al carril elegido// LO HACE EN EL STATE RUN
#	var target_x = lanes[lane_x + 1]
#	position.x = lerp(position.x, target_x, 0.1)

#func _input(event):
#	if event.is_action_pressed("ui_left") and lane_x > -1:
#		lane_x -= 1
#	elif event.is_action_pressed("ui_right") and lane_x < 1:
#		lane_x += 1

#funciones que usan los estados
func play_animation(anim_name: String):
	$AnimatedSprite2D.play(anim_name)
