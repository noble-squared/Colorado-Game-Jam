class_name platform extends Node2D


#@export var test_type: testEnum
@export var type : Globals.States

@onready var day_layer: TileMapLayer = $DayLayer
@onready var night_layer: TileMapLayer = $NightLayer
@onready var disabled_layer: TileMapLayer = $DisabledLayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(type)
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	_on_day_swapped()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_day_swapped():
	if type == Globals.States.DAY:
		day_layer.visible = true
		day_layer.enabled = true
		disabled_layer.visible = false
	elif type == Globals.States.NIGHT:
		night_layer.visible = false
		night_layer.enabled = false
		disabled_layer.visible = true
		
	
func _on_night_swapped():
	if type == Globals.States.DAY:
		day_layer.visible = false
		day_layer.enabled = false
		disabled_layer.visible = true
	elif type == Globals.States.NIGHT:
		night_layer.visible = true
		night_layer.enabled = true
		disabled_layer.visible = false
