extends Button


func _on_pressed() -> void:
	print("toMainMenu pressed")
	Globals.playClickSFX()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
