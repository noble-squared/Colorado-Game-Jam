extends CharacterBody2D

@onready var sun_moon: AnimatedSprite2D = $Sun_Moon
@onready var remote_ui: AnimatedSprite2D = $RemoteUI



func _ready() -> void:
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	_on_day_swapped()

func _on_day_swapped():
	sun_moon.frame = 0
	remote_ui.play('DaySwap')
	
func _on_night_swapped():
	sun_moon.frame = 1
	remote_ui.play('NightSwap')
