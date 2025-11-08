extends State

class_name Jump
var jump_time = 0.0
var jump_duration = 1.1
var jump_height = 140
var base_y = 0

#entro en estado Jump
func enter(character):
	#reproducir animacion salto
	#print("Animaciones disponibles: ", character.get_node("AnimatedSprite2D").sprite_frames.get_animation_names())
	character.play_animation("jump")
	jump_time = 0.0
	base_y = character.position.y
	
	#desactivar colisiones
	character.set_collision_layer(0)
	character.set_collision_mask(0)
	
func update(character, delta):
	jump_time += delta
	
	var t = jump_time / jump_duration
	character.position.y = base_y - sin(t * PI) * jump_height
	
	if jump_time >= jump_duration:
		character.position.y = base_y
		character.state_machine.change_state(character.run_state, character)
	
	#si el personaje toca el piso, volvemos a run
	#if character.is_on_floor():
	#	character.state_machine.change_state(character.run_state, character)
		
#salimos de jump
func exit(character):
	character.set_collision_layer(1)
	character.set_collision_mask(2)
	print ("Sali del estado: Jump")
