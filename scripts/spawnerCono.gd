extends Node2D

@export var obstacle_scene: PackedScene
@export var min_time := 0
@export var max_time := 2.5
@export var start_offset := 0.2

# ---- velocidad (tuneable) ----
@export var base_speed := 100.0     
@export var max_speed  := 380.0      
@export var time_to_max:= 120.0       
@export var min_gap_px : float = 160.0      

@export var spawn_chance: float = 0.10

var spawn_timer := 0.0
var next_spawn_time := 0.0
var run_time := 0.0
var lanes: Array[float] = [200.0, 400.0, 600.0]

func _ready():
	randomize()
	spawn_timer = -start_offset
	_set_next_time()

func _process(delta):
	run_time += delta
	spawn_timer += delta
	if spawn_timer >= next_spawn_time:
		spawn_timer = 0.0
		if randf() <= spawn_chance:
			spawn_obstacle()
		_set_next_time()

func _set_next_time():
	next_spawn_time = randf_range(min_time, max_time)

func _current_speed() -> float:
	var denom: float = maxf(time_to_max, 0.001)
	var t: float = clampf(run_time / denom, 0.0, 1.0)
	return lerpf(base_speed, max_speed, t)

func spawn_obstacle():
	if obstacle_scene == null:
		push_error("%s: obstacle_scene no asignado" % name)
		return

	var speed_now := _current_speed()
	var lane : float = SpawnRules.pick_lane_with_gap(lanes, min_gap_px, speed_now)

	var obstacle = obstacle_scene.instantiate()
	obstacle.position = Vector2(lane, -1050)
	obstacle.speed = speed_now              # << acelera con el tiempo
	add_child(obstacle)
