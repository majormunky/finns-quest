extends MarginContainer

@onready var text_label = $NinePatchRect/RichTextLabel

func show_dialog(text_to_show):
	text_label.text = text_to_show
	visible = true


func hide_dialog():
	text_label.text = ""
	visible = false
