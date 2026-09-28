extends Node

var levels = [
	"res://Scenes/levels/level_1.tscn",
	"res://Scenes/levels/JackM_level_1.tscn",
	"res://Scenes/levels/level_hayden_1.tscn",
]

var current_level = 0

var sounds: Dictionary[String, String] = {
	"lose": "res://assets/sounds/prison-cell-door.mp3",
	"rewind": "res://assets/sounds/tape-rewind.mp3"
}

var loadedSounds: Dictionary[String, AudioStreamPlayer2D] = {}

var music: Dictionary[String, String] = {
	"main": "res://assets/sounds/MainLevelTheme.mp3"
}

var loadedMusic: Dictionary[String, AudioStreamPlayer2D] = {}

var currSong: String = ""

enum States {NIGHT, DAY}

var current_state
var times_swapped: int = 0
var clickSFX: AudioStreamPlayer2D

signal NightSwapped
signal DaySwapped

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_state = States.DAY
	DaySwapped.emit()
	for sound in sounds.keys():
		var player = AudioStreamPlayer2D.new()
		print("Loading sound: " + sound)
		player.stream = AudioStreamMP3.load_from_file(sounds[sound])
		add_child(player)
		player.process_mode = Node.PROCESS_MODE_ALWAYS
		loadedSounds[sound] = player
	
	for song in music.keys():
		var player = AudioStreamPlayer2D.new()
		print("Loading sound: " + song)
		player.stream = AudioStreamMP3.load_from_file(music[song])
		add_child(player)
		loadedMusic[song] = player
		
	clickSFX = AudioStreamPlayer2D.new()
	clickSFX.stream = AudioStreamMP3.load_from_file("res://assets/sounds/click.mp3")
	add_child(clickSFX)

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

func playClickSFX():
	clickSFX.pitch_scale = randf_range(0.8,1.2)
	clickSFX.play()

func playSound(soundname: String, time: float = 0):
	if (soundname in loadedSounds.keys()):
		print("Playing sound: " + soundname)
		loadedSounds[soundname].play(time)
	else:
		push_warning("Attempt to play non-loaded sound: " + soundname)

func playMusic(songName: String):
	stopMusic()
	if (songName in loadedMusic.keys()):
		print("Playing song: " + songName)
		loadedMusic[songName].play()
		currSong = songName
	else:
		push_warning("Attempt to play non-loaded song: " + songName)

func stopMusic():
	if (currSong):
		loadedMusic[currSong].stop()
		currSong = ""
