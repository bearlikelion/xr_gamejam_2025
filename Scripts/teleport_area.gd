@tool
extends XRToolsTeleportArea

@onready var her_sound: AudioStreamPlayer = $"../../HerSound"


func _on_interactable_area_button_button_pressed(_button: Variant) -> void:
	monitoring = true
	her_sound.play()
