extends CharacterBody2D

@onready var sun_moon: AnimatedSprite2D = $Sun_Moon
@onready var remote_ui: AnimatedSprite2D = $RemoteUI
@onready var miniKey = $MiniKey

var hasKey = false

func _ready() -> void:
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	Globals.connect("KeyHitDoor", _dropKey)
	_on_day_swapped()
	miniKey.frame = 1
	miniKey.visible = false

func _on_day_swapped():
	sun_moon.frame = 0
	remote_ui.play('DaySwap')
	_dropKey()
	
func _on_night_swapped():
	sun_moon.frame = 1
	remote_ui.play('NightSwap')

func pickUpKey():
	miniKey.visible = true
	hasKey = true

func _dropKey():
	miniKey.visible = false
	hasKey = false
