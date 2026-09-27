extends AnimatedSprite2D


func _ready() -> void:
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	_on_day_swapped()
	
	
func _on_day_swapped():
	frame = 1
	
func _on_night_swapped():
	frame = 0
