extends Node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('screenshot'):
		var img = get_viewport().get_texture().get_image()
		var time = Time.get_datetime_string_from_system(false)
		time = time.replace(":", "_")
		var dir = DirAccess.open("user://")
		if !dir.dir_exists_absolute("screenshots"):
			makeDir()
		var filePath = "user://screenshots//image_" + time + ".png"
		img.save_png(filePath)

func makeDir():
	var dir = DirAccess.open("user://")
	dir.make_dir("screenshots")
