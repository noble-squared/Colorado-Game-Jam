extends Button

@export var level : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !level: level = "res://Scenes/main_menu.tscn"
	else: 
		level = "res://Scenes/" + level + ".tscn"


func _on_pressed() -> void:
	print(level)
	get_tree().change_scene_to_file(level)
