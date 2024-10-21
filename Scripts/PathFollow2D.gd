extends PathFollow2D

@export var speed : float
@export var stops_at_edges : bool = false
@export var stop_time : float
@onready var path = get_parent().curve
@onready var mob = get_child(0)

var point_count
var point_0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	point_count = path.point_count
	point_0 = path.get_point_position(0)
	print(point_count)
	
func _process(delta):
	progress += delta * speed
	
	if mob.name == "MovingHead":
		var mob_position = mob.get_global_position()
		if progress_ratio > 0.99:
			print("koniec")
			
		if progress_ratio > 0.49 and progress_ratio < 0.51:
			print("środek")
