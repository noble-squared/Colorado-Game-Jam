extends Control

func _ready() -> void:
	visible = false

func win():
	visible = true
	get_tree().paused = true
