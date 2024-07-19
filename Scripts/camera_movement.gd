extends Node2D

@export var noise_shake_speed: float = 30.0
@export var noise_shake_strength: float = 60.0
@export var shake_decay_rate: float = 5.0

@onready var camera = $Camera
@onready var rand = RandomNumberGenerator.new()
@onready var noise = FastNoiseLite.new()

var noise_i: float = 0.0

var shake_strength: float = 0.0
 
func _ready():
	rand.randomize()
	noise.seed = rand.randi()
	noise.frequency = 2
	
func _process(delta: float) ->void:
	shake_strength = noise_shake_strength
	shake_strength = lerp(shake_strength, 0.0, shake_decay_rate * delta)
	#var tween = create_tween()
	#tween.tween_property(camera, "offset", get_noise_offset(delta), 1.0)
	camera.offset = get_noise_offset(delta)
	
func get_noise_offset(delta: float) -> Vector2:
	noise_i += delta * noise_shake_speed
	return Vector2(noise.get_noise_2d(1, noise_i) * shake_strength, noise.get_noise_2d(100, noise_i) * shake_strength)
