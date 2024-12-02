extends Node2D

signal map_loaded(map_name)
var last_map_name = null
var current_map = null

var maps = {
	"World": load("res://maps/World.tscn"),
	"Town": load("res://maps/Town.tscn"),
}

func _ready() -> void:
	pass


func load_map(map_name):
	# check if we have a map loaded already
	if current_map:
		# if so, remove it
		current_map.queue_free()
		current_map = null
	
	var new_map = maps[map_name].instantiate()
	# TODO: Fix this later, it causes an error just by adding child directly
	# but if we call deferred, the map doesn't get added in time
	# for the setup_teleporters call to run
	call_deferred("add_child", new_map)
	await get_tree().create_timer(0.1).timeout
	# add_child(new_map)
	
	current_map = new_map
	current_map.setup_teleporters()
	current_map.connect("teleporter_hit", _on_teleporter_hit)
	map_loaded.emit(map_name)


func get_marker_position(pos_name):
	print("World Manager - Get Marker", pos_name)
	return current_map.get_marker_position(pos_name)


func _on_teleporter_hit(teleporter_name):
	load_map(teleporter_name)
