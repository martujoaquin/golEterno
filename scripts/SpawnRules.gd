extends Node

const MIN_BLOCK_MS: int = 120

# último uso de cada carril: key=float (lane), value=int (ms)
var last_lane_time: Dictionary[float, int] = {}

func pick_lane_with_gap(candidates: Array[float], min_gap_px: float, speed_px_s: float) -> float:
	var now: int = Time.get_ticks_msec()
	var block_ms: int = int(maxf(MIN_BLOCK_MS, (min_gap_px / maxf(speed_px_s, 1.0)) * 1000.0))

	var shuffled: Array[float] = candidates.duplicate()
	shuffled.shuffle()

	for lane: float in shuffled:
		var t: int = int(last_lane_time.get(lane, -1))
		if t == -1 or (now - t) > block_ms:
			last_lane_time[lane] = now
			return lane

	# si todos están bloqueados, devolvemos alguno igual para no frenar el spawn
	var lane_fallback: float = shuffled[0]
	last_lane_time[lane_fallback] = now
	return lane_fallback
