extends StaticBody2D

signal on_player_interaction(text)
@export_multiline var sign_text: String

func _on_interactable_interacted_with() -> void:
	print("Sign interacted with: " + sign_text)
	on_player_interaction.emit(sign_text)
