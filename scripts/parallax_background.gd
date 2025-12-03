extends ParallaxBackground

@export var bg_speed: float = 120.0

func _process(delta: float) -> void:
	scroll_base_offset.y += bg_speed * delta
