extends Node2D

@export var target : PackedScene
var sceneLoadStatus = 0

func _ready():
	SaveSystem.load_config()
	ResourceLoader.load_threaded_request(target.resource_path)
	
func _process(delta):
	sceneLoadStatus = ResourceLoader.load_threaded_get_status(target.resource_path)
	if sceneLoadStatus == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(target.resource_path)
		await $Timer.timeout
		$AnimatedSprite2D.hide()
		
		get_tree().change_scene_to_packed(newScene)
	
