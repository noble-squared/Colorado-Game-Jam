extends Node2D

func _ready() -> void:
	Globals.DaySwapped.connect(func(): visible = true)
	Globals.NightSwapped.connect(func(): visible = false)
