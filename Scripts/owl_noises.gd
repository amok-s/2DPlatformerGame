extends AnimationPlayer

var hooting_time = false
@onready var timer = $"../../Timer"


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = randf_range(2, 8)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hooting_time:
		hooting_time = false
		hoot()

func hoot():
	var x = randi_range(1,2)
	if x == 1:
		play("hoot_1")
	elif x == 2:
		play("hoot_2")
	reset_timer()
		
		
func reset_timer():
	timer.wait_time = randf_range(20, 35)
	timer.start()


func _on_timer_timeout():
	hooting_time = true
