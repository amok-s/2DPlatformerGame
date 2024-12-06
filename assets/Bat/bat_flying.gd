extends State
class_name BatFlying

@onready var sprite = $"../../sprite"
@onready var bat = $"../.."

var marker_node
var positions : Array
var temp_positions : Array
var current_position : Marker2D
var direction : Vector2 = Vector2.ZERO

func Enter():
	marker_node = $"../..".marker_node
	sprite.play("ceiling_out")
	await get_tree().create_timer(1.3).timeout
	sprite.play("flying")
	if marker_node:
		positions = marker_node.get_children()
	get_positions()
	get_next_position()
	$"../../Chirping".play(0)
	$"../../Chirping".connect("finished", replay_chirping)

func Exit():
	bat.velocity = Vector2(0, 0)
	
func Update(_delta:float):
	if direction:
		bat.velocity = direction * 310
	if current_position:
		if bat.global_position.distance_to(current_position.position) < 10:
			get_next_position()
			
	if bat.taking_damage == true:
		state_transition.emit(self, "Damage")

func get_positions():
	temp_positions = positions.duplicate()
	temp_positions.shuffle()
	
func get_next_position():
	if temp_positions.is_empty():
		get_positions()
	current_position = temp_positions.pop_front()
	direction = bat.to_local(current_position.position).normalized()

func replay_chirping():
	$"../../Chirping".play(0)
