extends Button

func _on_pressed() -> void:
	Globals.playClickSFX()
	get_tree().paused = false
	print("Quitting")
	get_tree().quit()
