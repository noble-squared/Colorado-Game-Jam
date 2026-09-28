extends Node2D
@onready var color_rect: ColorRect = $ColorRect
@export var type : Globals.States

var blue = Color(0.322, 0.69, 0.925, 1.0)
var black = Color(0.0, 0.0, 0.0, 1.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	_on_day_swapped()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_day_swapped():
	color_rect.set_color(blue) 
	
		
	
func _on_night_swapped():
	color_rect.set_color(black) 

		
