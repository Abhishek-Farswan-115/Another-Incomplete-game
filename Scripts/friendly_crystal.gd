extends CharacterBody3D

@export var speed: = 10.0

@onready var follower_nav: NavigationAgent3D = $Follower_Nav

var player: CharacterBody3D = null
var destination: = Vector3.ZERO


func _ready() -> void:
	player = get_tree().root.get_node("Land/Warrior")
	global_position = player.global_position
	global_position.y += 5
	destination = global_position


func _physics_process(delta):
	var new_destination: = player.global_position
	new_destination.y += 5
	new_destination +=  Vector3(1, 0, 0).rotated(Vector3(1, 0, 0), player.rotation.x)
	destination = destination.lerp(new_destination, delta * 20)
	if global_position.distance_to(destination) > 2:
		velocity = velocity.lerp(global_position.direction_to(destination) * speed, delta * 20)
		move_and_slide()
		look_at(destination)


func update_ally_location(ally_location):
	follower_nav.set_ally_location(ally_location)


func _on_follower_nav_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .25)
	move_and_slide()
