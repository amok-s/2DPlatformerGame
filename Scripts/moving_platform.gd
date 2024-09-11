extends AnimatableBody2D

@export var moving_time: float = 2.0
@export var idle_time: float = 1.7
@export var speed: float = 60

var go_left = false
var go_right = false
var switch = false

func _ready():
	idle_timer()


func _process(delta):
	if go_left == true:
		print("idzie w lewo")
		position -= transform.x * speed * delta
	elif go_right == true:
		print("idzie w prawo")
		position += transform.x * speed * delta
	
func blink_timer():
		await get_tree().create_timer(randf_range(2.8, 4.0)).timeout
		$Sprite.play("blink")
		await get_tree().create_timer(0.3).timeout
		$Sprite.animation = "idle"
		await get_tree().create_timer(randf_range(0.4, 6)).timeout

func moving_timer():
		print("moving timer")
		print("w lewo" + str(go_left))
		print("w prawo" + str(go_right))
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = moving_time
		timer.one_shot = true
		timer.connect("timeout", idle_timer)
		timer.start()
		if switch == false:
			go_left = true
		elif switch == true:
			go_right = true

func idle_timer():
	print("idle timer")
	if go_left == true:
		switch = true
	if go_right == true:
		switch = false
	go_left = false
	go_right = false
	var i_timer = Timer.new()
	add_child(i_timer)
	i_timer.wait_time = idle_time
	i_timer.one_shot = true
	i_timer.connect("timeout", moving_timer)
	i_timer.start()
