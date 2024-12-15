extends Node2D

var is_new_game = true
var current_map_name = null
var start_map_name = "World"
var dialog_active = false

@onready var world_manager = $WorldManager
@onready var player = $Player
@onready var ui = $UI

func _ready():
	world_manager.load_map(start_map_name)

func _on_world_manager_map_loaded(map_name: Variant) -> void:
	print("Map Loaded: ", map_name)
	print("New Game: ", is_new_game)
	var player_pos = null
	if is_new_game:
		player_pos = world_manager.get_marker_position("GameStart")
		is_new_game = false
	else:
		# find the position based on our last map
		player_pos = world_manager.get_marker_position("From" + current_map_name)
	
	# we can now change the current map name to our newly loaded map
	current_map_name = map_name
	
	# position player
	player.position = player_pos

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Debug"):
		if ui.dialog_active:
			ui.hide_dialog()
			ui.dialog_active = false
			get_tree().paused = false
		else:
			ui.show_dialog("Welcome to Finn's Quest!")
			ui.dialog_active = true
			get_tree().paused = true
