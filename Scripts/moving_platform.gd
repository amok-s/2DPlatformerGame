extends AnimatableBody2D

@export var moving_time: float = 2.0
@export var idle_time: float = 1.7
@export var speed: float = 60
@export var UpDown_motion: bool = false

var go_there = false
var go_back = false
var switch = false

func _ready():
	idle_timer()
	blink_timer()


func _process(delta):
	if UpDown_motion == false:
		if go_there == true:
			position -= transform.x * speed * delta
		elif go_back == true:
			position += transform.x * speed * delta
	
	elif UpDown_motion == true:
		if go_there == true:
			position -= transform.y * speed * delta
		elif go_back == true:
			position += transform.y * speed * delta
	
	
func blink_timer():
		await get_tree().create_timer(randf_range(2.8, 4.0)).timeout
		$Sprite.play("blink")
		await get_tree().create_timer(0.3).timeout
		$Sprite.animation = "idle"
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = randf_range(0.4, 6)
		timer.one_shot = true
		timer.connect("timeout", blink_timer)
		timer.start()

func moving_timer():
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = moving_time
		timer.one_shot = true
		timer.connect("timeout", idle_timer)
		timer.start()
		if switch == false:
			go_there = true
		elif switch == true:
			go_back = true

func idle_timer():
	if go_there == true:
		switch = true
	if go_back == true:
		switch = false
	go_there = false
	go_back = false
	var i_timer = Timer.new()
	add_child(i_timer)
	i_timer.wait_time = idle_time
	i_timer.one_shot = true
	i_timer.connect("timeout", moving_timer)
	i_timer.start()
