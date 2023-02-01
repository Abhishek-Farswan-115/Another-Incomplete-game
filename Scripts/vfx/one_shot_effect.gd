extends GPUParticles3D

func _init() -> void:
	emitting = true


func _process(_delta: float) -> void:
	if !emitting:
		queue_free()
