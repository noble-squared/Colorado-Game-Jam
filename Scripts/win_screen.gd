extends Control

func _ready() -> void:
	visible = false

func win():
	visible = true
	Globals.playSound("win")
	Globals.swappingDisabled = true
	if (Globals.highestUnlockedLevel == Globals.current_level):
		Globals.highestUnlockedLevel += 1
		Globals.saveGame()
	get_tree().paused = true


func _on_next_button_pressed() -> void:
	Globals.playClickSFX()
	print("button Pressed")
	Globals.next_level()
