@tool
extends XRToolsPickable

@onready var message: Label3D = $Message

func _on_body_entered(body: Node) -> void:
	if body is GlassBarrier:
		body.shatter()


func _on_grabbed(pickable: Variant, by: Variant) -> void:
	message.show()
