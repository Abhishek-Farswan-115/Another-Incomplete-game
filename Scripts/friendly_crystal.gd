extends CharacterBody3D

@export var speed: = 10.0

@onready var follower_nav: NavigationAgent3D = $Follower_Nav

var player: CharacterBody3D = null
var destination: = Vector3.ZERO


func _ready() -> void:
	player = get_tree().root.get_node("Land/Warrior")


func _process(_delta: float) -> void:
	look_at(player.global_position + player.velocity)
