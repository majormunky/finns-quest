extends Area2D

signal teleporter_entered(teleporter_name)


func _on_area_entered(area: Area2D) -> void:
	print("Something Walked on me! -> " + area.name)
	print("Teleporter Name: " + name)
	teleporter_entered.emit(name)
