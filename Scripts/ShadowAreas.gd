extends Area2D

var originalColour
func _ready():
	var enemies = get_node("../Enemies group").get_children(false)
 
func _on_body_entered(body):
	if body.name != "TileMap":
		originalColour = body.modulate
		showShadow(body)

func _on_body_exited(body):
	var tween = get_tree().create_tween()
	tween.tween_property(body, "modulate", Color(1, 1, 1), 0.6).set_ease(Tween.EASE_IN)

func showShadow(character):
	var tween = get_tree().create_tween()
	tween.tween_property(character, "modulate", Color(0.621, 0.556, 0.634), 0.6).set_ease(Tween.EASE_IN)
