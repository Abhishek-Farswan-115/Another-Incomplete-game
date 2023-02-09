extends Node

signal point_changed(point: int)
signal kill_changed(value: int)

var points: = 0:
	set(value):
		points = value
		point_changed.emit(points)
var kills: = 0:
	set(value):
		kills = value
		kill_changed.emit(kills)


func add_point(value: int) -> void:
	points += value


func add_kill() -> void:
	kills += 1
