extends Node2D

@export var flying_range : int = 70

var random_point : Vector2
var wander_time : float
var current_pos : Vector2
var initial_pos : Vector2
var final_pos : Vector2

var flying = true
var light = true
var darkness = false
var pulses = false

var smaller_light_energy
var bigger_light_energy
var bigger_light_scale

var pulses_tween

var range = randi_range(16, 27)
var await_time

func _ready():
	smaller_light_energy = $SmallerLight.energy
	bigger_light_energy = $BiggerLight.energy
	bigger_light_scale = $BiggerLight.texture_scale
	initial_pos = get_global_position()
	current_pos = get_global_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flying:
		randomize_direction()
		fly()
	if light:
		light_pulses()
		
	if !pulses and pulses_tween:
		pulses_tween.kill()
func randomize_direction():
	flying = false
	random_point = Vector2(randi_range(-range, range), randi_range(-range, range))
	if (random_point + current_pos).distance_to(initial_pos) > flying_range:
		while (random_point + current_pos).distance_to(initial_pos) > flying_range:
			random_point = Vector2(randi_range(-range, range), randi_range(-range, range))
	wander_time = randf_range(0.7, 1.3)

func fly():
	var tween = get_tree().create_tween()
	current_pos = get_global_position()
	final_pos = current_pos + random_point
	look_at(final_pos)
	tween.tween_property(self, "global_position", final_pos, wander_time)
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(flying_bool_change)
	
func flying_bool_change():
	await get_tree().create_timer(randf_range(0, 0.12)).timeout
	flying = true
	
func light_pulses():
	light = false
	var small_tween = get_tree().create_tween()
	var bigger_tween = get_tree().create_tween()
	var bigger_scale = get_tree().create_tween()
	var rand_time = randf_range(0.4, 1.2)
	
	if ($SmallerLight.energy == smaller_light_energy): #ściemnianie
		small_tween.tween_property($SmallerLight, "energy", 2.3, rand_time)
		bigger_tween.tween_property($BiggerLight, "energy", 1.4, rand_time)
		bigger_scale.tween_property($BiggerLight, "texture_scale", $SmallerLight.texture_scale, rand_time)
		bigger_tween.tween_callback(darkness_change)
		
	else: #rozjaśnianie
		small_tween.tween_property($SmallerLight, "energy", smaller_light_energy, rand_time)
		bigger_tween.tween_property($BiggerLight, "energy", bigger_light_energy, rand_time)
		bigger_scale.tween_property($BiggerLight, "texture_scale", bigger_light_scale, rand_time)
		bigger_tween.tween_callback(darkness_change)
	small_tween.tween_callback(light_bool_change).set_delay(0.05)


func light_bool_change():
	await_time = randf_range(0, 0.1) if darkness else randf_range(1.4, 2.2)
	if !darkness:
		pulses = true
		pulsating()
	await get_tree().create_timer(await_time).timeout
	light = true
	if !darkness:
		pulses = false

func darkness_change():
	if !darkness:
		darkness = true
	else:
		darkness = false

func pulsating():
	for n in 8:
		if pulses and get_tree():
			pulses_tween = get_tree().create_tween()
			var time = randf_range(0.2, 0.7)
			pulses_tween.tween_property($BiggerLight, "texture_scale", $BiggerLight.texture_scale - 0.1 if $BiggerLight.texture_scale == bigger_light_scale else bigger_light_scale, time)
			await get_tree().create_timer(time).timeout
	
