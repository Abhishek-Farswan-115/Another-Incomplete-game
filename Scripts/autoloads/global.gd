extends Node

signal point_changed(point: int)

var points: = 0:
	set(value):
		points = value
		point_changed.emit(points)


func add_point(value: int) -> void:
	points += value
