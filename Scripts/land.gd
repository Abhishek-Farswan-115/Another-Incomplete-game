extends Node3D

@export var max_enemies: = 10
@export var spawn_distance: = 50.0

@onready var player = $Warrior
@onready var enemies: Node3D = $Enemies

const reaper_scene: PackedScene = preload("res://Scenes/reaper.tscn")


func _physics_process(_delta):
#	get_tree().call_group("Ally","update_ally_location",player.global_transform.origin)
	get_tree().call_group("Enemy","Update_target_location",player.global_transform.origin)


func _on_spawn_timer_timeout() -> void:
	if enemies.get_child_count() < max_enemies:
		var reaper: = reaper_scene.instantiate()
		add_child(reaper)
		reaper.global_position = player.global_position + Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)) * spawn_distance
