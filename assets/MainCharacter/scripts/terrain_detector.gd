extends Area2D

enum specialTerrain {
	MUD = 1
}

var current_tilemap: TileMap
var current_terrain = 0


func tile_map_collision(body : Node2D, body_rid : RID) -> void:
	current_tilemap = body
	
	var colided_tile_coords = current_tilemap.get_coords_for_body_rid(body_rid)
	var tile_data = current_tilemap.get_cell_tile_data(0, colided_tile_coords)
	
	var terrain_type = tile_data.get_custom_data_by_layer_id(0)
	if terrain_type:
		match terrain_type:
			1:
				current_terrain = specialTerrain.MUD
				change_terrain(0.45, 0.85)
	else:
		current_terrain = 0
		change_terrain()
	

func _on_body_shape_entered(body_rid : RID, body : Node2D, body_shape_index : int, local_shape_index : int):
	if body is TileMap:
		tile_map_collision(body, body_rid)
	else:
		change_terrain()
		current_terrain = 0

		
		
func change_terrain(speed = 1, jump = 1):
	$"..".speed_modifier = speed
	await get_tree().create_timer(0.2).timeout
	$"..".jump_modifier = jump

