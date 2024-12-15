extends CanvasLayer

@onready var dialog = $Dialog
var dialog_active = false

func show_dialog(text):
	dialog.show_dialog(text)

func hide_dialog():
	dialog.hide_dialog()
