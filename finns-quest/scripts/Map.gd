extends Node2D

signal teleporter_hit(teleporter_name)
@onready var teleporters = $Teleporters
@onready var positions = $Positions

func setup_teleporters():
	for teleporter in teleporters.get_children():
		teleporter.connect("body_entered", _on_teleporter_hit.bind(teleporter))

func get_marker_position(marker_name):
	for child in positions.get_children():
		if child.name == marker_name:
			return child.position
	return null

func _on_teleporter_hit(_body, teleporter):
	teleporter_hit.emit(teleporter.name)
