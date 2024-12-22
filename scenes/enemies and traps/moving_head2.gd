extends AnimatableBody2D

func _ready():
	$Sprite.animation = "idle"
	$BlinkTimer.start(2)

func _physics_process(_delta):
	if $BlinkTimer.is_stopped():
		blink_timer()
	
func blink_timer():
	$Sprite.animation = "blink"
	await get_tree().create_timer(0.3).timeout
	$Sprite.animation = "idle"
	$BlinkTimer.start(randf_range(3, 5))

