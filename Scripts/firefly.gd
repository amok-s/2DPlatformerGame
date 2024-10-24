extends Node2D

@export var flying_range : int

var random_point : Vector2
var wander_time : float
var current_pos : Vector2
var initial_pos : Vector2
var final_pos : Vector2

var flying = true
var light = true
var darkness = false
var pulse = false

var smaller_light_energy
var bigger_light_energy
var bigger_light_scale

var range = randi_range(12, 25)
var await_time

func _ready():
	smaller_light_energy = $SmallerLight.energy
	bigger_light_energy = $BiggerLight.energy
	bigger_light_scale = $BiggerLight.texture_scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flying:
		randomize_direction()
		fly()
	if light:
		light_pulses()
func randomize_direction():
	flying = false
	random_point = Vector2(randi_range(-range, range), randi_range(-range, range))
	wander_time = randf_range(0.4, 0.8)

func fly():
	var tween = get_tree().create_tween()
	current_pos = get_global_position()
	final_pos = current_pos + random_point
	look_at(final_pos)
	tween.tween_property(self, "global_position", final_pos, wander_time)
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(flying_bool_change)
	
func flying_bool_change():
	await get_tree().create_timer(randf_range(0, 0.08)).timeout
	flying = true
	
func light_pulses():
	light = false
	var small_tween = get_tree().create_tween()
	var bigger_tween = get_tree().create_tween()
	var bigger_scale = get_tree().create_tween()
	var rand_time = randf_range(0.4, 2.00)
	
	if ($SmallerLight.energy == smaller_light_energy): #ściemnianie
		small_tween.tween_property($SmallerLight, "energy", 0.8, rand_time)
		bigger_tween.tween_property($BiggerLight, "energy", 1.4, rand_time)
		bigger_scale.tween_property($BiggerLight, "texture_scale", $SmallerLight.texture_scale, rand_time)
		darkness = true
		
	else: #rozjaśnianie
		small_tween.tween_property($SmallerLight, "energy", smaller_light_energy, rand_time)
		bigger_tween.tween_property($BiggerLight, "energy", bigger_light_energy, rand_time)
		bigger_scale.tween_property($BiggerLight, "texture_scale", bigger_light_scale, rand_time)
		darkness = false
	small_tween.tween_callback(light_bool_change)
	if !darkness and pulsating:
		pulses()

func light_bool_change():
	await_time = randf_range(0, 0.3) if darkness else randf_range(1.3, 2.2)
	await get_tree().create_timer(await_time).timeout
	light = true
	
	

func pulses():
	var tween = get_tree().create_tween()
	var time = randf_range(0.5, 0.7)
	tween.set_loops()
	tween.tween_property($BiggerLight, "texture_scale", $BiggerLight.texture_scale - 0.1 if $BiggerLight.texture_scale == bigger_light_scale else bigger_light_scale, time)
	tween.tween_interval(time)
	
