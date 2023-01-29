extends Node2D
@export var Credit_scene : PackedScene


func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://Scenes/land.tscn")


func _on_credit_button_button_up():
	get_tree().change_scene_to_packed(Credit_scene)
