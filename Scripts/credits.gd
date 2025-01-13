extends Control

@export var credits_node : PackedScene

var b

func show_credits():
	b = credits_node.instantiate()
	add_child(b)
	b.show_credits()
	
func end_credits():
	if b:
		b.queue_free()

func return_to_main():
	hide()
	$"../MenuBox".show()
	$"../Logo".show()
	$"../MenuBox/MainMenu/Play".grab_focus()
