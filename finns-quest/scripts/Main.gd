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
	
	# setup interactable signals
	for node in get_tree().get_nodes_in_group("interactable"):
		node.on_player_interaction.connect(on_player_interaction)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Inspect"):
		if ui.dialog_active:
			ui.hide_dialog()
			get_tree().paused = false
			await get_tree().create_timer(0.1).timeout
			ui.dialog_active = false


func on_player_interaction(text: String) -> void:
	print("Player interacted with something:" + text)
	if ui.dialog_active == false:
		ui.show_dialog(text)
		ui.dialog_active = true
		get_tree().paused = true
