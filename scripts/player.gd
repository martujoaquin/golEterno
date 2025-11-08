extends CharacterBody2D

var speed = 0
var lane_x = 0  # -1 = izquierda, 0 = centro, 1 = derecha
var lanes = [250.0, 450.0, 650.0]  # posiciones X de carriles (ajustá según tu escena)

var state_machine: StateMachine
var run_state: Run
var jump_state: Jump

func _ready():
	# arranca en el carril del medio
	position = Vector2(lanes[1], 500)  # arranca en el carril del medio
	
	#inicio la maquina de estados
	state_machine = StateMachine.new()
	run_state = Run.new()
	jump_state = Jump.new()
	
	#empezamos en run
	state_machine.change_state(run_state, self)
	
func _physics_process(delta):
	#position.y -= speed * delta
	state_machine.update(self, delta)


#funciones que usan los estados
func play_animation(anim_name: String):
	$AnimatedSprite2D.play(anim_name)

func play_emote():
	$AnimatedSprite2D.play("emote") 
