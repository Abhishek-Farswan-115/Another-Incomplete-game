extends Node2D

@export_file("*.tscn") var game_scene_path

@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar


func _ready() -> void:
	ResourceLoader.load_threaded_request(game_scene_path)


func _process(delta: float) -> void:
	var progress: = []
	var sceneLoadStatus = ResourceLoader.load_threaded_get_status(game_scene_path, progress)
	
	progress_bar.value = lerp(progress_bar.value, progress[0] * 100, delta * 10) 
	
	if sceneLoadStatus == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(game_scene_path))
		queue_free()
