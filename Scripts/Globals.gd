extends Node

var levels = [
	"res://Scenes/levels/level_1.tscn",
	"res://Scenes/levels/JackM_level_1.tscn",
	"res://Scenes/levels/level_hayden_1.tscn",
]

var current_level = 0


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

func next_level():
	current_level += 1
	if (current_level >= len(levels)):
		current_level = 0
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		return
	get_tree().change_scene_to_file(levels[current_level])

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
