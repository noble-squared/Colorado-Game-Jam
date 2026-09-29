extends Button

@export var level : String
@export var levelIndex: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.loadGame()
	if !level: level = "res://Scenes/main_menu.tscn"
	else: 
		level = "res://Scenes/levels/" + level + ".tscn"
	if (levelIndex > Globals.highestUnlockedLevel):
		disabled = true
		text = "Locked"


func _on_pressed() -> void:
	print(level)
	Globals.playClickSFX()
	Globals.current_level = levelIndex
	get_tree().change_scene_to_file(level)
