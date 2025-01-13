extends Node2D


func offset_tween(node, time : float, offset : Vector2):
	var tween = get_tree().create_tween()
	var target_offset = node.position + offset
	tween.set_parallel()
	tween.tween_property(node, "position", target_offset, time)
	tween.set_trans(Tween.TRANS_CUBIC)

func fade_tween(node, time : float, fade_in : bool = true):
	var modulate_val
	if fade_in:
		node.modulate = Color(1, 1, 1, 0)
		modulate_val = Color(1, 1, 1)
	else:
		node.modulate = Color(1, 1, 1)
		modulate_val = Color(1, 1, 1, 0)
	
	node.show()
	var tween = get_tree().create_tween()
	
	tween.tween_property(node, "modulate", modulate_val, time)
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_CUBIC)

func show_credits():
	for child in get_children():
		child.hide()
		show()
		
	fade_tween($Logo, 0.7)
	offset_tween($Logo, 1, Vector2(0, - 40))
	await get_tree().create_timer(0.5).timeout
	
	fade_tween($Author, 0.7)
	offset_tween($Author, 1, Vector2(0, - 40))
	await get_tree().create_timer(2.5).timeout
	fade_tween($Author, 0.7, false)
	fade_tween($Logo, 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween($Assets, 0.7)
	offset_tween($Assets, 1, Vector2(0, - 40))
	await get_tree().create_timer(3.5).timeout
	fade_tween($Assets, 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween($Audio, 0.7)
	offset_tween($Audio, 1, Vector2(0, - 40))
	await get_tree().create_timer(3.5).timeout
	fade_tween($Audio, 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	fade_tween($Tutorials, 0.7)
	offset_tween($Tutorials, 1, Vector2(0, - 40))
	await get_tree().create_timer(3.5).timeout
	fade_tween($Tutorials, 0.7, false)
	await get_tree().create_timer(0.5).timeout
	
	get_parent().return_to_main()
	get_parent().end_credits()

	

