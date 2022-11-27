extends CharacterBody3D
@onready var fella_nev = $Follower_Nav

var SPEED = 10


func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = fella_nev.get_next_location()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	fella_nev.set_velocity(new_velocity)

func update_ally_location(ally_location):
	fella_nev.set_ally_location(ally_location)


func _on_follower_nav_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .25)
	move_and_slide()
