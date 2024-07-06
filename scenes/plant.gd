extends RigidBody2D

@export var particle : PackedScene
@onready var spawn_projectile_sound = $SpawnProjectileSound
@onready var plant_sprite = $PlantSprite


var shooting = false
var particles = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func timer():
	var random = randf_range(4, 6)
	await get_tree().create_timer(random).timeout
	shooting = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	if (shooting == true):
		shooting = false
		await get_tree().create_timer(3).timeout
		plant_sprite.animation = "attack"
		await get_tree().create_timer(0.5).timeout
		spawn_particle()
		plant_sprite.animation = "idle"


func spawn_particle():
	var particle_node = particle.instantiate()
	particle_node.position = position + Vector2(-60, -8)
	get_parent().add_child(particle_node)
	spawn_projectile_sound.play(0)
	print ("adding plant particle")


func _on_timer_timeout():
	timer()
