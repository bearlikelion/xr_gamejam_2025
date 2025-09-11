class_name GlassBarrier
extends StaticBody3D

@onready var glass_shatter: AudioStreamPlayer = $"../../GlassShatter"


func shatter() -> void:
	glass_shatter.play()
	queue_free()
