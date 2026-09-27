extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	Globals.setDayNight(Globals.States.DAY)
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_day_swapped():
	print("Changed to day")
	
	
func _on_night_swapped():
	print("changed to night")
