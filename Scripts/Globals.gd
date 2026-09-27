extends Node


enum States {NIGHT, DAY}

var current_state
var times_swapped: int = 0

signal NightSwapped
signal DaySwapped

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = States.DAY
	DaySwapped.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("SwapTime"):
		swapState()


func swapState():
	times_swapped += 1
	if current_state == States.NIGHT:
		current_state = States.DAY
		DaySwapped.emit()
	elif current_state == States.DAY:
		current_state = States.NIGHT
		NightSwapped.emit()

func setDayNight(targetState: States):
	if (current_state != targetState):
		current_state = targetState
		if (targetState == States.DAY):
			DaySwapped.emit()
		else:
			NightSwapped.emit()
