@tool
extends XRToolsTeleportArea

@onready var her_sound: AudioStreamPlayer = $"../../HerSound"
@onready var xr_player: XRPlayer = get_tree().get_first_node_in_group("XRPlayer")


func _on_interactable_area_button_button_pressed(_button: Variant) -> void:
	monitoring = true
	xr_player.become_her()
