extends Control

func _ready() -> void:
	visible = false

func win():
	visible = true
	get_tree().paused = true


func _on_next_button_pressed() -> void:
	print("button Pressed")
	Globals.next_level()
