extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var eyes = $Eyes
@onready var Anim = $AnimationPlayer

@export var SPEED = 3
@export var Turn_speed = 2

enum {
	IDLE,
	WALK,
	ATTACK,
}
var state = IDLE
var Target = null
var target_in_attack_range: = false

func _process(_delta):
	match state:
		WALK:
			eyes.look_at(Target.global_transform.origin, Vector3.UP)
			rotate_y(deg_to_rad(eyes.rotation.y * Turn_speed))
		ATTACK:
			Anim.play("Attack")

func _physics_process(_delta):
	if state == WALK:
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_location()
		var new_velocity = (next_location - current_location).normalized() * SPEED
		nav_agent.set_velocity(new_velocity)

func Update_target_location(target_location):
	nav_agent.set_target_location(target_location)

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .25)
	move_and_slide()

func _on_range_body_entered(body):
	if body.is_in_group("Player"):
		state = WALK
		Target = body
		Update_target_location(Target.global_transform.origin)
		Anim.play("Walk")

func _on_range_body_exited(_body):
	state = IDLE
	Target = null
	Anim.play("Idle")

func _on_attack_range_body_entered(body: Node3D) -> void:
	if Target == body:
		state = ATTACK
		target_in_attack_range = true

func _on_attack_range_body_exited(body: Node3D) -> void:
	if Target == body:
		target_in_attack_range = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack" and !target_in_attack_range:
		if is_instance_valid(Target):
			state = WALK
		else:
			state = IDLE

