extends Node2D
class_name Level

@export var maxJumpsBeforeGem: int = -1
var gotGem: bool = false
@export var maxJumpsTotal: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.swappingDisabled = false
	Globals.connect("DaySwapped", _on_day_swapped)
	Globals.connect("NightSwapped", _on_night_swapped)
	Globals.setDayNight(Globals.States.DAY)
	Globals.playMusic("main")
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func checkIfTooManyJumps():
	if (Globals.times_swapped == maxJumpsTotal):
		find_child("Player").find_child("PlayerHealth").die("You ran out of power!")
	
	if (Globals.times_swapped == maxJumpsBeforeGem && not gotGem):
		find_child("Player").find_child("PlayerHealth").die("The gem was transported away!")


func _on_day_swapped():
	checkIfTooManyJumps()
	print("Changed to day")
	
	
func _on_night_swapped():
	checkIfTooManyJumps()
	print("changed to night")
