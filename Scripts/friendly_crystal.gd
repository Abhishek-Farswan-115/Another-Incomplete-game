extends CharacterBody3D

@export var speed: = 10.0

@onready var follower_nav: NavigationAgent3D = $Follower_Nav
@onready var static_position: = position

var player: CharacterBody3D = null
var destination: = Vector3.ZERO
var pick_ups: = []


func _ready() -> void:
	player = get_tree().root.get_node("Land/Warrior")


func _physics_process(delta: float) -> void:
	if pick_ups:
		top_level = true
		if global_position.distance_to(pick_ups[0].global_position) < 1:
			Global.add_point(1)
			pick_ups[0].queue_free()
			pick_ups.pop_front()
		else:
			velocity = lerp(
				velocity, 
				global_position.direction_to(pick_ups[0].global_position) * speed, 
				delta * 10
			)
			move_and_slide()
	else:
		look_at(player.global_position + player.velocity)
		top_level = false
		if position.distance_to(static_position) > 1:
			velocity = lerp(velocity, position.direction_to(static_position) * speed, delta * 20)
			move_and_slide()


func _on_pick_up_range_body_entered(body: Node3D) -> void:
	pick_ups.erase(body)
	body.queue_free()
	Global.add_point(1)


func _on_active_range_body_entered(body: Node3D) -> void:
	pick_ups.push_back(body)


func _on_active_range_body_exited(body: Node3D) -> void:
	pick_ups.erase(body)
