extends Node2D

@export var medalla_scene: PackedScene

@export var min_interval: float = 10     # mismos valores que tus coins
@export var max_interval: float = 10
@export var min_y_gap: float = 160.0   # separación mínima con obstáculos
#@export var lane_tolerance: float = 20.0      # porque nunca están EXACTO misma X

@export var spawn_y: float = -1000.0
@export var LANES: Array[float] = [200.0, 400.0, 600.0]

@onready var timer: Timer = $MedallaTimer
@onready var rng := RandomNumberGenerator.new()

var last_lane:= -1

func _ready() -> void:
	rng.randomize()
	_start_random_timer()


func _start_random_timer() -> void:
	timer.wait_time = rng.randf_range(min_interval, max_interval)
	timer.start()


func _on_medalla_timer_timeout() -> void:
	if medalla_scene == null:
		return
	
	var attempts := 0
	var lane_idx := -1
	var pos := Vector2.ZERO
	
	while attempts < 5:
		var candidate := _pick_lane_no_repeat()
		var candidate_pos := Vector2(LANES[candidate], spawn_y)

		if _lane_has_space(candidate, candidate_pos.y):
			lane_idx = candidate
			pos = candidate_pos
			break
	
		attempts+=1
	
	if lane_idx == -1:
		return
		
	var medalla = medalla_scene.instantiate()
	#if medalla.has_variable("lane_idx"):
	#	medalla.lane_idx = lane_idx
	
	var parent = get_parent()
	if parent == null:
		parent = get_tree().current_scene
	parent.add_child(medalla)
	
	medalla.global_position = pos

func _pick_lane_no_repeat() -> int:
	var idx := rng.randi_range(0, LANES.size() -1)
	if idx == last_lane and LANES.size() > 1:
		idx = (idx + 1)% LANES.size()
	last_lane = idx
	return idx

func _lane_has_space(lane_idx: int, new_y: float) -> bool:
	for o in get_tree().get_nodes_in_group("obstacles"):
		if o is ObstacleBase and o.lane_idx == lane_idx:
			if abs(o.global_position.y - new_y) < min_y_gap:
				return false
	return true
