extends Node2D
@onready var color_rect: ColorRect = $ColorRect
@export var type : Globals.States
var blue = Color(82.928, 120.076, 128.484, 1.0)
var black = Color(0.0, 0.0, 0.0, 1.0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_day_swapped():
	if type == Globals.States.DAY:
		color_rect.set_color(blue) 
	elif type == Globals.States.NIGHT:
		color_rect.set_color(black) 
		
