class_name platform extends Node2D


#@export var test_type: testEnum
@export var type : Globals.States

@onready var sprite_2d: Sprite2D = $AnimatableBody2D/Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $AnimatableBody2D/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	_on_day_swapped()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_day_swapped():
	if type == Globals.States.DAY:
		collision_shape_2d.disabled = false
	elif type == Globals.States.NIGHT:
		collision_shape_2d.disabled = true
	
func _on_night_swapped():
	if type == Globals.States.DAY:
		collision_shape_2d.disabled = true
	elif type == Globals.States.NIGHT:
		collision_shape_2d.disabled = false
