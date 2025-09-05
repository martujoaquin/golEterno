extends Node2D

@export var obstacle_scene: PackedScene
var spawn_timer = 0.0
var lanes = [150.0, 250.0, 350.0]

func _process(delta):
	spawn_timer += delta
	if spawn_timer > 2.0: # cada 2 segundos
		spawn_timer = 0.0
		spawn_obstacle()

func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()
	obstacle.position = Vector2(lanes.pick_random(), -180) # aparece arriba
	add_child(obstacle)
