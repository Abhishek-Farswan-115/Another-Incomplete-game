extends Node3D

@export var damage: = 20.0
@export var knock_back: = 100.0


func _ready() -> void:
	$HitBox/CollisionShape3D.disabled = true
