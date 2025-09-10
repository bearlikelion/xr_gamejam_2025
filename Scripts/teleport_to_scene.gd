@tool
class_name TeleportToScene
extends Area3D


## Target scene file
@export_file('*.tscn') var scene : String

@onready var staging: XRToolsStaging = get_tree().get_first_node_in_group("Staging")

# Add support for is_xr_class on XRTools classes
func is_xr_class(name : String) -> bool:
	return name == "XRToolsTeleportArea"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Handle body entered
	body_entered.connect(_on_body_entered)


# Handle body entering area
func _on_body_entered(body : Node3D) -> void:
	# Test if the body is the player
	var player_body := body as XRToolsPlayerBody
	if not player_body:
		return

	# Teleport to new scene
	staging.load_scene(scene)


func _on_interactable_area_button_button_pressed(_button: Variant) -> void:
	monitoring = true
