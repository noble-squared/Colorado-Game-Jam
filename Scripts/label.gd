extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	_on_day_swapped()
	
	
func _on_day_swapped():
	text = "Day"
	
func _on_night_swapped():
	text = "Night"
