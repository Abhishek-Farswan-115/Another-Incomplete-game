extends Node3D

@onready var Player = $Warrior

func _physics_process(_delta):
	get_tree().call_group("Ally","update_ally_location",Player.global_transform.origin)
	get_tree().call_group("Enemy","Update_target_location",Player.global_transform.origin)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
