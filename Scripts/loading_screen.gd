extends Node2D

var sceneLoadStatus = 0
var sceneName

# Called when the node enters the scene tree for the first time.
func _ready():
	$Arc1.hide()
	$Arc2.hide()
	$Arc3.hide()
	if GlobalLevelManager.currentArc == 1:
		$Arc1.show()
	if GlobalLevelManager.currentArc == 2:
		$Arc2.show()
	if GlobalLevelManager.currentArc == 3:
		$Arc3.show()
	sceneName = GlobalLevelManager.nextLevelPath
	ResourceLoader.load_threaded_request(sceneName)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sceneLoadStatus = ResourceLoader.load_threaded_get_status(sceneName)
	if sceneLoadStatus == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		SceneTransition.change_scene(newScene)
