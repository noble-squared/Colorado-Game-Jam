extends Button

@export var level : String
@export var levelIndex: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !level: level = "res://Scenes/main_menu.tscn"
	else: 
		level = "res://Scenes/levels/" + level + ".tscn"


func _on_pressed() -> void:
	print(level)
	Globals.current_level = levelIndex
	get_tree().change_scene_to_file(level)
