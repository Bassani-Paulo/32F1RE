extends Control


func setup(text:String):
	get_node("MarginContainer/VBoxContainer/RichTextLabel").bbcode_text = text
