extends CharacterBody3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _init() -> void:
	velocity = Vector3(1, 0, 0).rotated(Vector3.UP, randf() * PI) * 10


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	velocity.x = move_toward(velocity.x, 0, delta * 5)
	velocity.z = move_toward(velocity.z, 0, delta * 5)

	move_and_slide()
