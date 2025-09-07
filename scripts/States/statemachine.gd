extends Node

class_name StateMachine

var current_state: State = null

func change_state(new_state: State, character):
	if current_state != null:
		current_state.exit(character)
	current_state = new_state
	current_state.enter(character)

func update(character, delta):
	if current_state != null:
		current_state.update(character, delta)
