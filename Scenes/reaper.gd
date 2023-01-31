extends CharacterBody3D

enum {
	IDLE,
	WALK,
	ATTACK,
}

@onready var nav_agent = $NavigationAgent3D
@onready var eyes = $Eyes
@onready var Anim = $AnimationPlayer
@onready var i_frame_timer: Timer = $IFrameTimer
@onready var hurt_box_collision_shape: CollisionShape3D = $HurtBox/CollisionShape3D
@onready var enemy_health_bar: TextureProgressBar = $Sprite3D/SubViewport/EnemyHealthBar

@export var SPEED = 3
@export var Turn_speed = 2
@export var max_health: = 100.0
@export var knock_back: = 20.0

var state = IDLE
var Target = null
var target_in_attack_range: = false
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var health: = max_health:
	set(value):
		health = value
		enemy_health_bar.value = health


func _ready() -> void:
	enemy_health_bar.max_value = max_health


func _process(_delta):
	match state:
		WALK:
			eyes.look_at(Target.global_transform.origin, Vector3.UP)
			rotate_y(deg_to_rad(eyes.rotation.y * Turn_speed))
		ATTACK:
			Anim.play("Attack")


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if state == WALK:
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_location()
		var new_velocity = (next_location - current_location).normalized() * SPEED
		nav_agent.set_velocity(new_velocity)
	else:
		velocity.x = lerp(velocity.x, 0.0, delta * 20)
		velocity.z = lerp(velocity.z, 0.0, delta * 20)
	move_and_slide()

func Update_target_location(target_location):
	nav_agent.set_target_location(target_location)

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .25)
	

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
	if anim_name == "Attack":
		if target_in_attack_range:
			look_at(Target.global_position)
		else:
			if is_instance_valid(Target):
				state = WALK
			else:
				state = IDLE


func _on_hurt_box_area_entered(area: Area3D) -> void:
	var node: Node3D = area.owner
	if "knock_back" in node:
		velocity += node.global_position.direction_to(global_position) * node.knock_back
	if "damage" in node:
		health -= node.damage
		if health <= 0:
			queue_free()
	i_frame_timer.start()
	hurt_box_collision_shape.set_deferred("disabled", true)


func _on_i_frame_timer_timeout() -> void:
	hurt_box_collision_shape.disabled = false
