extends Node2D

# Pre-cargamos los distintos tipos de obstáculos
const OBSTACLE_SCENES := [
	preload("res://scenes/obstacles/cono.tscn"),
	preload("res://scenes/obstacles/pelota.tscn"),
]

# Carriles o posiciones posibles (ajustá según tus lanes reales)
@export var LANES: Array[float] = [200.0, 400.0, 600.0]

# Intervalos de aparición (segundos)
@export var min_interval: float = 1.4
@export var max_interval: float = 2.2

# Posición Y inicial (aparecen desde arriba)
@export var spawn_y: float = -1000

@export var min_y_gap: float = 160.0

@onready var rng := RandomNumberGenerator.new()
@onready var timer: Timer = $SpawnTimer

var last_lane := -1  # para no repetir dos veces el mismo carril seguido

func _ready() -> void:
	rng.randomize()
	_spawn_once()  # spawnea algo al inicio
	_start_random_timer()

func _start_random_timer() -> void:
	timer.wait_time = rng.randf_range(min_interval, max_interval)
	timer.start()

func _on_spawn_timer_timeout() -> void:
	_spawn_once()
	_start_random_timer()

func _spawn_once() -> void:
	var attempts :=0
	var lane_idx :=-1
	var pos := Vector2.ZERO
	
	while attempts <5:
		var candidate := _pick_lane_no_repeat()
		var candidate_pos := Vector2(LANES[candidate],spawn_y)
		if _lane_has_space(candidate, candidate_pos.y):
			lane_idx = candidate
			pos = candidate_pos
			break
		attempts += 1
	
	if lane_idx == -1:
		return
		
	
	var scene: PackedScene = OBSTACLE_SCENES[rng.randi_range(0, OBSTACLE_SCENES.size() - 1)]
	var obstacle: ObstacleBase = scene.instantiate()
	obstacle.lane_idx = lane_idx
	obstacle.global_position = pos

	var parent = get_parent()
	if parent == null:
		parent = get_tree().current_scene
	parent.add_child(obstacle)
	
func _pick_lane_no_repeat() -> int:
	var idx := rng.randi_range(0, LANES.size()-1)
	if idx == last_lane and LANES.size() > 1:
		idx = (idx + 1) % LANES.size()
	last_lane = idx
	return idx
		
		
func _lane_has_space(lane_idx: int, new_y: float) -> bool:
	for o in get_tree().get_nodes_in_group("obstacles"):
		if o is ObstacleBase and o.lane_idx == lane_idx:
			if abs(o.global_position.y - new_y) < min_y_gap:
				return false
	return true		
