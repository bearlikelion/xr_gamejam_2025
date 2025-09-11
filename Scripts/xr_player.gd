class_name XRPlayer
extends XROrigin3D

@export var enable_teleport: bool = true

const HER_HANDS = preload("res://Assets/Hands/her_hands.tres")
const HER_NAILS = preload("res://Assets/Hands/her_nails.tres")
const HIS_HANDS = preload("res://Assets/Hands/his_hands.tres")
const HIS_NAILS = preload("res://Assets/Hands/his_nails.tres")

signal became_him()
signal became_her()

enum Person {HIM, HER}

var current_person = Person.HIM

@onready var player_body: XRToolsPlayerBody = $PlayerBody
@onready var him: Person = get_tree().get_first_node_in_group("Him")
@onready var her: Person = get_tree().get_first_node_in_group("Her")
@onready var him_sound: AudioStreamPlayer = $"../HimSound"
@onready var her_sound: AudioStreamPlayer = $"../HerSound"

@onready var left_hand: MeshInstance3D = get_tree().get_first_node_in_group("LeftHand")
@onready var right_hand: MeshInstance3D = get_tree().get_first_node_in_group("RightHand")

@onready var remote_rotation: RemoteTransform3D = $XRCamera3D/RemoteRotation
@onready var remote_position: RemoteTransform3D = $RemotePosition

func _ready() -> void:
	if him:
		remote_rotation.remote_path = him.get_path()
		remote_position.remote_path = him.get_path()


func _on_left_hand_controller_button_pressed(button: String) -> void:
	if her and current_person != Person.HER \
	and button == "ax_button" or button == "by_button" and enable_teleport:
		become_her()


func _on_right_hand_controller_button_pressed(button: String) -> void:
	if him and current_person != Person.HIM \
	and button == "ax_button" or button == "by_button" and enable_teleport:
		become_him()


func become_him() -> void:
	print("Become Him")
	current_person = Person.HIM
	player_body.teleport(him.global_transform)
	his_hands()
	remote_rotation.remote_path = him.get_path()
	remote_position.remote_path = him.get_path()
	him_sound.play()
	became_him.emit()


func become_her() -> void:
	print("Become Her")
	current_person = Person.HER
	player_body.teleport(her.global_transform)
	her_hands()
	remote_rotation.remote_path = her.get_path()
	remote_position.remote_path = her.get_path()
	her_sound.play()
	became_her.emit()


func her_hands() -> void:
	left_hand.mesh.surface_set_material(0, HER_HANDS)
	left_hand.mesh.surface_set_material(1, HER_NAILS)
	right_hand.mesh.surface_set_material(0, HER_HANDS)
	right_hand.mesh.surface_set_material(1, HER_NAILS)


func his_hands() -> void:
	left_hand.mesh.surface_set_material(0, HIS_HANDS)
	left_hand.mesh.surface_set_material(1, HIS_NAILS)
	right_hand.mesh.surface_set_material(0, HIS_HANDS)
	right_hand.mesh.surface_set_material(1, HIS_NAILS)
