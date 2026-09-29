extends Control

@onready var scrollingPart: CenterContainer = $CenterContainer
var scrollSpeed = 85

func _process(delta: float) -> void:
	scrollingPart.position.y -= delta * scrollSpeed
	if (scrollingPart.position.y < -scrollingPart.size.y):
		var tween = get_tree().create_tween()
		tween.tween_property($FadeToBlack, "color", Color.BLACK, 1)
		tween.tween_callback(func(): get_tree().change_scene_to_file("res://Scenes/main_menu.tscn"))
	
