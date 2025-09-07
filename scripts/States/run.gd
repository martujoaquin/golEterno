extends State #hereda de State.gd

class_name Run #nombre a este estado

#cuando el personaje entra en este estado
func enter(character):
	#le decimos que animacion reproducir
	character.play_animation("run")
	print("Entre en estado: Run")

func update(character, delta):
	var target_x = character.lanes[character.lane_x +1]
	character.position.x = lerp(character.position.x,target_x,0.1)
	
	#detectar si quiere cambiar de carril
	if Input.is_action_just_pressed("ui_left") and character.lane_x > -1:
		character.lane_x -=1
	elif Input.is_action_just_pressed("ui_right") and character.lane_x < 1:
		character.lane_x +=1
	#detectar si quiere saltar:
	if Input.is_action_just_pressed("ui_up"):
		character.state_machine.change_state(character.jump_state, character)
		
# Más adelante: inputs para saltar o patear
# if Input.is_action_just_pressed("jump"):
#     character.state_machine.change_state(character.jump_state, character)
# if Input.is_action_just_pressed("kick"):
#     character.state_machine.change_state(character.kick_state, character)

#al salir del estado
func exit (character):
	print("Sali del estado: Run")
